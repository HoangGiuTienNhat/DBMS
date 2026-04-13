import {
  Injectable,
  NotFoundException,
  BadRequestException,
  ForbiddenException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { Review } from '../../entities/review.entity';
import { Product } from '../../entities/product.entity';
import { User } from '../../entities/user.entity';
import {
  CreateReviewDto,
  UpdateReviewDto,
  ReviewQueryDto,
  ReviewResponseDto,
  ProductReviewStatsDto,
  ReviewStatsDto,
} from '../../dto/review.dto';
import { FirestoreReviewsService } from '../../services/firestore-reviews.service';

@Injectable()
export class ReviewsService {
  constructor(
    @InjectRepository(Review)
    private reviewRepository: Repository<Review>,
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
    @InjectRepository(User)
    private userRepository: Repository<User>,
    private dataSource: DataSource,
    private firestoreReviewsService: FirestoreReviewsService,
  ) {}

  async create(
    userId: string,
    createReviewDto: CreateReviewDto,
  ): Promise<ReviewResponseDto> {
    const { productId, rating, comment } = createReviewDto;

    // Check if product exists
    const product = await this.productRepository.findOne({
      where: { id: productId, isActive: true },
    });
    if (!product) {
      throw new NotFoundException('Product not found');
    }

    let review: ReviewResponseDto;
    
    try {
      // Try to create review in Firestore first
      review = await this.firestoreReviewsService.createReview(
        userId,
        productId,
        rating,
        comment,
      );
      console.log('✅ Review saved to Firestore:', review.id);
    } catch (error) {
      console.error('⚠️ Firestore save failed, falling back to PostgreSQL:', error.message);
      
      // Fallback: Save to PostgreSQL
      try {
        const pgReview = this.reviewRepository.create({
          userId,
          productId,
          rating,
          comment,
          isVerified: false,
          isActive: true,
        });
        const savedReview = await this.reviewRepository.save(pgReview);
        
        // Convert PostgreSQL review to response format
        review = {
          id: savedReview.REVIEW_ID,
          userId: savedReview.userId,
          productId: savedReview.productId,
          rating: savedReview.rating,
          comment: savedReview.comment,
          isVerified: savedReview.isVerified,
          isActive: savedReview.isActive,
          createdAt: savedReview.createdAt,
          updatedAt: savedReview.updatedAt,
          user: { id: '', name: '', email: '' },
          product: { id: '', name: '', title: '' },
        };
        console.log('✅ Review saved to PostgreSQL (Firestore backup failed):', review.id);
      } catch (pgError) {
        console.error('❌ Both Firestore and PostgreSQL failed:', pgError.message);
        throw new Error(`Failed to save review: ${pgError.message}`);
      }
    }

    // Update product average rating in PostgreSQL
    await this.updateProductRating(productId);

    // Enrich review with user and product data
    return this.enrichReviewResponse(review, productId, userId);
  }

  async findAll(queryDto: ReviewQueryDto): Promise<{
    reviews: ReviewResponseDto[];
    total: number;
    page: number;
    limit: number;
    totalPages: number;
  }> {
    const {
      page = 1,
      limit = 10,
      productId,
      userId,
      rating,
      isVerified,
    } = queryDto;

    // Get data from Firestore
    const result = await this.firestoreReviewsService.findAll(
      page,
      limit,
      productId,
      userId,
      rating,
      isVerified,
    );

    // Enrich reviews with user and product data
    const enrichedReviews = await Promise.all(
      result.reviews.map((review) =>
        this.enrichReviewResponse(review, review.productId, review.userId),
      ),
    );

    return {
      ...result,
      reviews: enrichedReviews,
    };
  }

  async findOne(id: string): Promise<ReviewResponseDto> {
    const review = await this.firestoreReviewsService.findOne(id);
    return this.enrichReviewResponse(review, review.productId, review.userId);
  }

  async findByProduct(
    productId: string,
    queryDto: ReviewQueryDto,
  ): Promise<{
    reviews: ReviewResponseDto[];
    total: number;
    page: number;
    limit: number;
    totalPages: number;
  }> {
    return this.findAll({ ...queryDto, productId });
  }

  async findByUser(
    userId: string,
    queryDto: ReviewQueryDto,
  ): Promise<{
    reviews: ReviewResponseDto[];
    total: number;
    page: number;
    limit: number;
    totalPages: number;
  }> {
    return this.findAll({ ...queryDto, userId });
  }

  async update(
    id: string,
    userId: string,
    updateReviewDto: UpdateReviewDto,
  ): Promise<ReviewResponseDto> {
    // Get review to check ownership
    const review = await this.firestoreReviewsService.findOne(id);
    
    // Check if user owns the review
    if (review.userId !== userId) {
      throw new ForbiddenException('You can only update your own reviews');
    }

    // Update in Firestore
    const updatedReview = await this.firestoreReviewsService.updateReview(
      id,
      updateReviewDto.rating,
      updateReviewDto.comment,
    );

    // Update product rating
    await this.updateProductRating(review.productId);

    return this.enrichReviewResponse(
      updatedReview,
      updatedReview.productId,
      updatedReview.userId,
    );
  }

  async remove(id: string, userId: string): Promise<{ message: string }> {
    // Get review to check ownership
    const review = await this.firestoreReviewsService.findOne(id);
    
    // Check if user owns the review
    if (review.userId !== userId) {
      throw new ForbiddenException('You can only delete your own reviews');
    }

    // Delete from Firestore
    const result = await this.firestoreReviewsService.deleteReview(id);

    // Update product rating
    await this.updateProductRating(review.productId);

    return result;
  }

  async adminRemove(id: string): Promise<{ message: string }> {
    // Get review first to update product rating
    const review = await this.firestoreReviewsService.findOne(id);

    // Delete from Firestore
    const result = await this.firestoreReviewsService.deleteReview(id);

    // Update product rating
    await this.updateProductRating(review.productId);

    return { message: 'Review deleted successfully by admin' };
  }

  async verifyReview(id: string): Promise<ReviewResponseDto> {
    const verifiedReview = await this.firestoreReviewsService.verifyReview(id);
    return this.enrichReviewResponse(
      verifiedReview,
      verifiedReview.productId,
      verifiedReview.userId,
    );
  }

  async getProductReviewStats(
    productId: string,
  ): Promise<ProductReviewStatsDto> {
    // Check if product exists
    const product = await this.productRepository.findOne({
      where: { id: productId, isActive: true },
    });
    if (!product) {
      throw new NotFoundException('Product not found');
    }

    // Get stats from Firestore
    return this.firestoreReviewsService.getProductReviewStats(productId);
  }

  async getReviewStats(): Promise<ReviewStatsDto> {
    const stats = await this.firestoreReviewsService.getReviewStats();
    return {
      totalReviews: stats.totalReviews,
      averageRating: stats.averageRating,
      verifiedReviews: stats.verifiedReviews,
      pendingReviews: stats.totalReviews - stats.verifiedReviews,
      recentReviews: [],
    };
  }

  private async updateProductRating(productId: string): Promise<void> {
    try {
      const stats =
        await this.firestoreReviewsService.getProductReviewStats(productId);
      
      await this.productRepository.update(productId, {
        averageRating: stats.averageRating,
        numReviews: stats.totalReviews,
      });
    } catch (error) {
      console.error('Failed to update product rating:', error);
    }
  }

  private async enrichReviewResponse(
    review: ReviewResponseDto,
    productId: string,
    userId: string,
  ): Promise<ReviewResponseDto> {
    try {
      const [user, product] = await Promise.all([
        this.userRepository.findOne({
          where: { UserID: userId },
          select: ['UserID', 'full_name', 'email', 'image'],
        }),
        this.productRepository.findOne({
          where: { id: productId },
          select: ['id', 'name', 'title', 'image'],
        }),
      ]);

      return {
        ...review,
        user: user
          ? {
              id: user.UserID,
              name: user.full_name || '',
              email: user.email || '',
              image: user.image,
            }
          : { id: userId, name: '', email: '' },
        product: product
          ? {
              id: product.id,
              name: product.name || '',
              title: product.title || '',
              image: product.image,
            }
          : { id: productId, name: '', title: '' },
      };
    } catch (error) {
      console.error('Failed to enrich review response:', error);
      return review;
    }
  }

  private formatReviewResponse(review: Review): ReviewResponseDto {
    return {
      id: review.id,
      userId: review.userId,
      productId: review.productId,
      rating: review.rating,
      comment: review.comment,
      isVerified: review.isVerified,
      isActive: review.isActive,
      createdAt: review.createdAt,
      updatedAt: review.updatedAt,
      user: review.user
        ? {
            id: review.user.id,
            name: review.user.name,
            email: review.user.email,
            image: review.user.image,
          }
        : {
            id: '',
            name: '',
            email: '',
            image: undefined,
          },
      product: review.product
        ? {
            id: review.product.id,
            name: review.product.name,
            title: review.product.title,
            image: review.product.image,
          }
        : {
            id: '',
            name: '',
            title: '',
            image: undefined,
          },
    };
  }
}
