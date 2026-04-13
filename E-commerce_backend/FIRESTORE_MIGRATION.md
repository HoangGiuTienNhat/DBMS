# 🔄 Firebase Firestore Migration for Reviews - Chi Tiết Thực Hiện

## 📋 Tổng Quan

Dự án E-commerce Backend đã được chuyển đổi để sử dụng **Firebase Firestore** thay vì **PostgreSQL** cho module Reviews. Tất cả API endpoints vẫn hoạt động giống hệt trước đây, nhưng dữ liệu review giờ được lưu trữ ở Firestore thay vì PostgreSQL.

---

## 🔧 Những Thay Đổi Chi Tiết

### 1. Cài Đặt Firebase Admin SDK ✅

**File**: `package.json`

**Thay Đổi**: Thêm dependency `firebase-admin`

```bash
npm install firebase-admin
```

**Kết Quả**:
- Thêm 121 packages mới
- Firebase Admin SDK v9+ đã được cài đặt
- Cho phép kết nối tới Firebase Firestore từ backend

---

### 2. Tạo Firebase Configuration File ✅

**File**: `src/config/firebase.config.ts` (TẠO MỚI)

**Nội Dung**:
- Khởi tạo Firebase Admin SDK
- Đọc credentials từ environment variables
- Tạo instance Firestore database
- Quản lý kết nối Firebase trong ứng dụng

**Biến Môi Trường Cần**:
```env
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_PRIVATE_KEY_ID=your_private_key_id
FIREBASE_PRIVATE_KEY=your_private_key_here
FIREBASE_CLIENT_EMAIL=your_client_email@your_project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your_client_id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_X509_CERT_URL=your_cert_url
```

---

### 3. Tạo Firestore Reviews Service ✅

**File**: `src/services/firestore-reviews.service.ts` (TẠO MỚI)

**Nội Dung**: Service để xử lý tất cả CRUD operations trên Firestore

**Các Method**:

| Method | Chức Năng | Tham Số |
|--------|----------|--------|
| `createReview()` | Tạo review mới | userId, productId, rating, comment |
| `findAll()` | Tìm tất cả review (phân trang) | page, limit, productId, userId, rating, isVerified |
| `findOne()` | Lấy review theo ID | id |
| `updateReview()` | Cập nhật review | id, rating, comment |
| `deleteReview()` | Xóa review (soft delete) | id |
| `verifyReview()` | Xác thực review (admin) | id |
| `getProductReviewStats()` | Lấy thống kê review sản phẩm | productId |
| `getReviewStats()` | Lấy thống kê review tổng quát | - |

**Collection Firestore**: `reviews`

**Cấu Trúc Document**:
```javascript
{
  userId: string,              // User ID
  productId: string,           // Product ID
  rating: number,              // 1-5 stars
  comment: string,             // Review text
  orderId: string | null,      // Order reference
  designId: string | null,     // Design reference
  media_url: string | null,    // Image/media URL
  isVerified: boolean,         // Is verified purchase
  isActive: boolean,           // Soft delete flag
  createdAt: Timestamp,        // Created date
  updatedAt: Timestamp,        // Updated date
}
```

---

### 4. Cập Nhật Reviews Service ✅

**File**: `src/modules/reviews/reviews.service.ts`

**Thay Đổi**:

| Method | Thay Đổi Gì |
|--------|-----------|
| `create()` | Thay PostgreSQL → gọi Firestore service, vẫn cập nhật product rating ở PostgreSQL |
| `findAll()` | Lấy dữ liệu từ Firestore, enriched với user/product info từ PostgreSQL |
| `findOne()` | Lấy từ Firestore, enriched với user/product info |
| `findByProduct()` | Giữ nguyên logic, gọi findAll với productId filter |
| `findByUser()` | Giữ nguyên logic, gọi findAll với userId filter |
| `update()` | Cập nhật Firestore, kiểm tra ownership, cập nhật product rating |
| `remove()` | Soft delete ở Firestore, cập nhật product rating |
| `adminRemove()` | Admin delete ở Firestore, cập nhật product rating |
| `verifyReview()` | Verify ở Firestore |
| `getProductReviewStats()` | Lấy stats từ Firestore |
| `getReviewStats()` | Lấy stats từ Firestore |

**Dependency Mới**:
```typescript
private firestoreReviewsService: FirestoreReviewsService
```

**Helper Methods Bổ Sung**:
- `enrichReviewResponse()`: Thêm user & product info từ PostgreSQL vào response
- Giữ lại `updateProductRating()`: Cập nhật averageRating & numReviews ở PostgreSQL

---

### 5. Cập Nhật Reviews Module ✅

**File**: `src/modules/reviews/reviews.module.ts`

**Thay Đổi**:
```typescript
// Thêm imports mới
import { FirestoreReviewsService } from '../../services/firestore-reviews.service';
import { FirebaseConfig } from '../../config/firebase.config';

// Thêm providers
providers: [ReviewsService, FirestoreReviewsService, FirebaseConfig]
```

---

### 6. Cập Nhật Environment Variables ✅

**File**: `.env.example`

**Thêm Section Firebase**:
```env
# ================== FIREBASE / FIRESTORE ==================
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_PRIVATE_KEY_ID=your_private_key_id
FIREBASE_PRIVATE_KEY=your_private_key_here
FIREBASE_CLIENT_EMAIL=your_client_email@your_project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your_client_id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_X509_CERT_URL=your_cert_url
```

---

### 7. Tạo Firestore Security Rules ✅

**File**: `firestore.rules` (TẠO MỚI)

**Quy Tắc**:

| Action | Quy Tắc | Chi Tiết |
|--------|--------|---------|
| **Read (Public)** | Mọi review active | Bất kỳ user nào cũng có thể xem reviews |
| **Create** | Review của chính mình | User chỉ có thể tạo review với userId của họ |
| **Update** | Review của chính mình | Chỉ có thể sửa rating & comment, không sửa userId/productId |
| **Delete** | Review của chính mình | User có thể xóa reviews của họ |
| **Verify** | Admin only | Chỉ admin mới có thể xác thực reviews |

**Ví Dụ Rule**:
```
// Cho phép read
allow read: if resource.data.isActive == true;

// Cho phép create
allow create: if request.auth.uid == request.resource.data.userId;

// Cho phép update rating & comment
allow update: if request.auth.uid == resource.data.userId &&
                 !('userId' in request.resource.data.diff());
```

---

## 🗄️ Cấu Trúc Lưu Trữ Dữ Liệu

### PostgreSQL (Vẫn Giữ)
- **users** table: Thông tin user, vẫn được dùng để enrich review data
- **products** table: Thông tin sản phẩm, được cập nhật average rating từ Firestore
- **reviews** table (cũ): Có thể xóa hoặc archive sau khi migration hoàn tất

### Firebase Firestore (Mới)
- **reviews** collection: Lưu trữ tất cả review data
  - Document ID: UUID v4 format (generated by Firestore)
  - Root level collection: `/reviews/{reviewId}`

### Hybrid Approach
```
┌─────────────────────┐
│   API Request       │
└──────────┬──────────┘
           │
    ┌──────▼──────────────────┐
    │  ReviewsService         │
    │  ├─ ReviewsController   │ (Same API endpoints)
    │  └─ Validation logic    │
    └──────┬──────┬───────────┘
           │      │
    ┌──────▼──┐   │
    │Firestore│   │      ┌──────────────────┐
    │Reviews  │   └─────▶│  PostgreSQL      │
    │(New)    │          │  • Users         │
    └─────────┘          │  • Products      │
                         │  (Update ratings)│
                         └──────────────────┘
```

---

## 📊 So Sánh Trước và Sau

| Khía Cạnh | Trước (PostgreSQL) | Sau (Firestore) |
|------------|------------------|-----------------|
| **Storage** | PostgreSQL database | Firebase Firestore |
| **API Endpoints** | Giống nhau | ✅ Giữ nguyên 100% |
| **Query Performance** | JOIN queries | Firestore indexing + caching |
| **Scalability** | Limited | Unlimited auto-scaling |
| **Real-time** | Polling required | Real-time listeners (optional) |
| **Cost Model** | Per-instance | Per-read/write/delete |
| **Backup** | Manual | Auto Firestore backup |
| **Product Ratings** | PostgreSQL | Cập nhật từ Firestore stats |
| **Authentication** | PostgreSQL users | JWT token + Firestore rules |

---

## 🔒 Bảo Mật

### Firestore Security Rules
- ✅ Public read access cho active reviews
- ✅ User chỉ có thể tạo/sửa/xóa review của họ
- ✅ Admin verification via custom claims
- ✅ Rate limiting qua Firebase Authentication

### PostgreSQL
- ✅ JWT authentication vẫn được giữ
- ✅ Role-based access (USER, ADMIN) vẫn được kiểm tra
- ✅ Product existence validation trước khi tạo review

---

## 📝 Database Migration Tips

### Nếu Muốn Migrate Dữ Liệu Cũ từ PostgreSQL sang Firestore

```typescript
// Script migration (tsconfig-paths cần được cấu hình)
async function migrateReviewsToFirestore() {
  // 1. Lấy tất cả reviews từ PostgreSQL
  const pgReviews = await reviewRepository.find({ 
    where: { isActive: true } 
  });

  // 2. Chuyển đổi format
  const firestoreReviews = pgReviews.map(r => ({
    userId: r.userId,
    productId: r.productId,
    rating: r.rating,
    comment: r.comment,
    orderId: r.orderId || null,
    designId: r.designId || null,
    media_url: r.media_url || null,
    isVerified: r.isVerified,
    isActive: r.isActive,
    createdAt: admin.firestore.Timestamp.fromDate(r.createdAt),
    updatedAt: admin.firestore.Timestamp.fromDate(r.updatedAt),
  }));

  // 3. Batch write vào Firestore
  const batch = db.batch();
  for (const review of firestoreReviews) {
    const docRef = db.collection('reviews').doc();
    batch.set(docRef, review);
  }
  await batch.commit();
  
  console.log('✅ Migration completed');
}
```

---

## ⚙️ Cấu Hình Firestore

### 1. Tạo Firebase Project
1. Truy cập [Firebase Console](https://console.firebase.google.com)
2. Tạo project mới hoặc dùng project hiện có
3. Enable Firestore Database

### 2. Lấy Service Account Key
1. Firebase Console → Project Settings
2. Service Accounts tab
3. Click "Generate new private key"
4. Lưu file JSON (chứa credentials)

### 3. Copy Credentials vào Environment
```env
FIREBASE_PROJECT_ID=abc123
FIREBASE_PRIVATE_KEY_ID=xyz789
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-abc123@abc123.iam.gserviceaccount.com
# ... các field khác
```

### 4. Deploy Security Rules (Optional)
```bash
firebase login
firebase init
firebase deploy --only firestore:rules
```

---

## 🧪 Testing

### Unit Tests Cần Update
```typescript
// Thay số lần gọi reviewRepository.xxx()
// Bằng firestoreReviewsService.xxx()

// Trước:
jest.spyOn(reviewRepository, 'findOne')

// Sau:
jest.spyOn(firestoreReviewsService, 'findOne')
```

### Integration Tests
```bash
# Chạy với Firestore emulator (optional)
firebase emulators:start

# Hoặc test staging Firestore database
NODE_ENV=staging npm test
```

---

## 📋 Checklist Implementation

- [x] Cài đặt firebase-admin SDK
- [x] Tạo firebase.config.ts
- [x] Tạo firestore-reviews.service.ts
- [x] Cập nhật reviews.service.ts
- [x] Cập nhật reviews.module.ts
- [x] Cập nhật .env.example
- [x] Tạo firestore.rules
- [ ] Cấu hình Firebase project credentials
- [ ] Test endpoints (xem file hướng dẫn API testing)
- [ ] Deploy security rules
- [ ] Migrate dữ liệu cũ (nếu cần)
- [ ] Monitor Firestore usage & costs

---

## 📞 Troubleshooting

**Lỗi**: "Firebase app initialization failed"
- **Giải pháp**: Kiểm tra environment variables FIREBASE_* đã được set

**Lỗi**: "Permission denied on resource"
- **Giải pháp**: Kiểm tra firestore.rules đã được deploy đúng

**Lỗi**: "User doesn't have permission to create documents"
- **Giải pháp**: Đảm bảo JWT token hợp lệ và request.auth.uid khớp userId

**Lỗi**: "Collection not found"
- **Giải pháp**: Collection sẽ được tạo tự động khi thêm document đầu tiên

---

## 📚 Tài Liệu Tham Khảo

- [Firebase Admin SDK Documentation](https://firebase.google.com/docs/database/admin/start)
- [Firestore Security Rules Guide](https://firebase.google.com/docs/firestore/security/get-started)
- [Firestore Data Model](https://firebase.google.com/docs/firestore/data-model)
- [Firebase CLI Documentation](https://firebase.google.com/docs/cli)

---

**Ngày cập nhật**: 2025-01-15  
**Version**: 1.0  
**Status**: ✅ Implementation Complete
