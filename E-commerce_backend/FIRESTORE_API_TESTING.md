# 🧪 API Testing Guide for Firestore Reviews Integration

## 📋 Tổng Quan

Hướng dẫn chi tiết cách kiểm tra tất cả API endpoints reviews sau khi chuyển sang Firebase Firestore. Hầu hết API endpoints vẫn giữ nguyên format trước.

---

## 🚀 Chuẩn Bị

### 1. Khởi Động Backend Server

```bash
cd E-commerce_backend

# Cài đặt dependencies (nếu chưa)
npm install

# Chạy server ở chế độ development
npm run start:dev
```

**Server chạy tại**: `http://localhost:5000`

### 2. Công Cụ Testing

Bạn có thể dùng một trong những công cụ sau:
- **Postman** (recommended) - Import collection
- **curl** - Command line
- **Thunder Client** - VS Code extension
- **Insomnia** - REST client

### 3. Firebase Setup

**Trước khi test, hãy chắc chắn rằng**:
- ✅ Firebase credentials đã được set trong `.env`
- ✅ Firestore database đã được tạo ở Firebase Console
- ✅ Backend không log lỗi Firebase khi khởi động

```bash
# Kiểm tra logs khi backend start
npm run start:dev
# Tìm: "✅ Firebase initialized successfully"
```

---

## 📊 Test Scenarios

### A. Authentication Flow (Prerequisite)

Trước khi test reviews, bạn cần có JWT token hợp lệ.

#### 1️⃣ Đăng Ký User Mới

```http
POST /api/auth/register
Content-Type: application/json

REQUEST:
{
  "name": "John Doe",
  "email": "john@test.com",
  "password": "password123",
  "phone": "+84901234567",
  "address": "123 Main St"
}

RESPONSE (201):
{
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "john@test.com",
    "name": "John Doe",
    "role": "USER"
  },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}

💾 Save: user_id = 550e8400-e29b-41d4-a716-446655440000
💾 Save: jwt_token = eyJhbGciOiJIUzI1NiIs...
```

#### 2️⃣ Đăng Nhập

```http
POST /api/auth/login
Content-Type: application/json

REQUEST:
{
  "email": "john@test.com",
  "password": "password123"
}

RESPONSE (200):
{
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "john@test.com",
    "name": "John Doe"
  },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}

💾 Save: jwt_token
```

---

### B. Reviews API Endpoints

#### 3️⃣ Tạo Review Mới

```http
POST /api/reviews
Authorization: Bearer {jwt_token}
Content-Type: application/json

REQUEST:
{
  "productId": "product-uuid-here",
  "rating": 4,
  "comment": "Great product! Very satisfied with the quality."
}

RESPONSE (201):
{
  "id": "firestore-doc-id",
  "userId": "550e8400-e29b-41d4-a716-446655440000",
  "productId": "product-uuid-here",
  "rating": 4,
  "comment": "Great product! Very satisfied with the quality.",
  "isVerified": false,
  "isActive": true,
  "createdAt": "2025-01-15T10:30:45.000Z",
  "updatedAt": "2025-01-15T10:30:45.000Z",
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "name": "John Doe",
    "email": "john@test.com"
  },
  "product": {
    "id": "product-uuid-here",
    "name": "Product Name",
    "title": "Product Title"
  }
}

✅ Success: Firebase Firestore document created
💾 Save: review_id = firestore-doc-id
```

**Kiểm tra Firestore**:
1. Firebase Console → Firestore → Collections
2. Bạn sẽ thấy collection `reviews` mới được tạo
3. Click vào để xem document vừa thêm

---

#### 4️⃣ Lấy Tất Cả Reviews (Phân Trang)

```http
GET /api/reviews?page=1&limit=10
Authorization: Bearer {jwt_token}
Content-Type: application/json

RESPONSE (200):
{
  "reviews": [
    {
      "id": "review-id-1",
      "userId": "user-id",
      "productId": "product-id",
      "rating": 4,
      "comment": "Great product!",
      "isVerified": false,
      "isActive": true,
      "createdAt": "2025-01-15T10:30:45.000Z",
      "updatedAt": "2025-01-15T10:30:45.000Z",
      "user": { ... },
      "product": { ... }
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 10,
  "totalPages": 1
}

✅ Success: Retrieved reviews from Firestore with pagination
```

**Test Filters**:
```http
# Filter by productId
GET /api/reviews?page=1&limit=10&productId={productId}

# Filter by userId
GET /api/reviews?page=1&limit=10&userId={userId}

# Filter by rating
GET /api/reviews?page=1&limit=10&rating=4

# Filter by verification
GET /api/reviews?page=1&limit=10&isVerified=false
```

---

#### 5️⃣ Lấy Review Theo ID

```http
GET /api/reviews/{review_id}
Content-Type: application/json

RESPONSE (200):
{
  "id": "review-id-1",
  "userId": "user-id",
  "productId": "product-id",
  "rating": 4,
  "comment": "Great product!",
  "isVerified": false,
  "isActive": true,
  "createdAt": "2025-01-15T10:30:45.000Z",
  "updatedAt": "2025-01-15T10:30:45.000Z",
  "user": { ... },
  "product": { ... }
}

✅ Success: Review retrieved from Firestore
```

---

#### 6️⃣ Lấy Reviews Của Sản Phẩm

```http
GET /api/reviews/product/{productId}?page=1&limit=5
Content-Type: application/json

RESPONSE (200):
{
  "reviews": [ ... ],
  "total": 2,
  "page": 1,
  "limit": 5,
  "totalPages": 1
}

✅ Success: Retrieved all reviews for product from Firestore
```

---

#### 7️⃣ Lấy Review Statistics Của Sản Phẩm

```http
GET /api/reviews/product/{productId}/stats
Content-Type: application/json

RESPONSE (200):
{
  "productId": "product-id",
  "averageRating": 4.5,
  "totalReviews": 2,
  "ratingDistribution": {
    "1": 0,
    "2": 0,
    "3": 0,
    "4": 1,
    "5": 1
  },
  "verifiedReviews": 0,
  "recentReviews": [
    {
      "id": "review-id",
      "rating": 5,
      "comment": "Excellent!",
      "createdAt": "2025-01-15T10:30:45.000Z"
    }
  ]
}

✅ Success: Statistics calculated from Firestore data
```

**Kiểm tra Firestore**:
1. Firebase Console → Firestore
2. Xem tất cả documents trong collection `reviews`
3. Verify rating distribution được tính đúng

---

#### 8️⃣ Lấy Reviews Của Người Dùng

```http
GET /api/reviews/my-reviews?page=1&limit=5
Authorization: Bearer {jwt_token}
Content-Type: application/json

RESPONSE (200):
{
  "reviews": [
    {
      "id": "review-id",
      "userId": "current-user-id",
      "productId": "product-id",
      "rating": 4,
      "comment": "Great product!",
      "isVerified": false,
      "isActive": true,
      "createdAt": "2025-01-15T10:30:45.000Z",
      "updatedAt": "2025-01-15T10:30:45.000Z",
      "user": { ... },
      "product": { ... }
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 5,
  "totalPages": 1
}

✅ Success: Retrieved user's reviews from Firestore
```

---

#### 9️⃣ Cập Nhật Review

```http
PATCH /api/reviews/{review_id}
Authorization: Bearer {jwt_token}
Content-Type: application/json

REQUEST:
{
  "rating": 5,
  "comment": "Actually, this product is amazing! 5 stars.
}

RESPONSE (200):
{
  "id": "review-id",
  "userId": "user-id",
  "productId": "product-id",
  "rating": 5,
  "comment": "Actually, this product is amazing! 5 stars.",
  "isVerified": false,
  "isActive": true,
  "createdAt": "2025-01-15T10:30:45.000Z",
  "updatedAt": "2025-01-15T11:00:00.000Z",
  "user": { ... },
  "product": { ... }
}

✅ Success: Review updated in Firestore
💡 Note: updatedAt timestamp should be newer
```

**Verify in Firestore**:
1. Firebase Console → Firestore → reviews collection
2. Find document by ID
3. Check rating and comment are updated
4. Check updatedAt timestamp changed

---

#### 🔟 Xóa Review

```http
DELETE /api/reviews/{review_id}
Authorization: Bearer {jwt_token}

RESPONSE (200):
{
  "message": "Review deleted successfully"
}

✅ Success: Review soft-deleted in Firestore (isActive = false)
```

**Verify in Firestore**:
1. Firebase Console → Firestore → reviews collection
2. Find the document deleted
3. Check `isActive` field is now `false` (soft delete, not hard delete)
4. GET /api/reviews/{review_id} should return 404

---

### C. Admin Operations (Requires Admin Token)

#### 🔐 Tạo Admin User

```bash
# Thực hiện ở PostgreSQL hoặc database admin tool
# Update user role = 'ADMIN'

UPDATE users SET role = 'ADMIN' WHERE email = 'admin@test.com'
```

#### 1️⃣ Verify Review (Admin Only)

```http
PATCH /api/reviews/{review_id}/verify
Authorization: Bearer {admin_jwt_token}

RESPONSE (200):
{
  "id": "review-id",
  "userId": "user-id",
  "productId": "product-id",
  "rating": 5,
  "comment": "Great product!",
  "isVerified": true,  // Changed to true
  "isActive": true,
  "createdAt": "2025-01-15T10:30:45.000Z",
  "updatedAt": "2025-01-15T11:05:00.000Z",
  "user": { ... },
  "product": { ... }
}

✅ Success: Review verified in Firestore (isVerified = true)
```

#### 2️⃣ Delete Review (Admin Only)

```http
DELETE /api/reviews/{review_id}/admin
Authorization: Bearer {admin_jwt_token}

RESPONSE (200):
{
  "message": "Review deleted successfully by admin"
}

✅ Success: Review soft-deleted by admin
```

#### 3️⃣ Get All Reviews (Admin Only)

```http
GET /api/reviews?page=1&limit=10
Authorization: Bearer {admin_jwt_token}

RESPONSE (200):
{
  "reviews": [ ... ],
  "total": 10,
  "page": 1,
  "limit": 10,
  "totalPages": 1
}

✅ Success: Admin can view all reviews from all users
```

#### 4️⃣ Get Review Statistics (Admin Only)

```http
GET /api/reviews/stats
Authorization: Bearer {admin_jwt_token}

RESPONSE (200):
{
  "totalReviews": 10,
  "averageRating": 4.2,
  "verifiedReviews": 5,
  "pendingReviews": 5,
  "recentReviews": []
}

✅ Success: Admin can view overall review statistics
```

---

## 🔍 Firestore Data Inspection

### 1. Xem Dữ Liệu trực tiếp ở Firestore

```
Firebase Console
  ↓
Select Project
  ↓
Firestore Database
  ↓
Collections
  ↓
reviews (collection)
  ↓
{document_id} (documents)
  ↓
View fields: userId, productId, rating, comment, isVerified, etc.
```

### 2. Query Data ở Firestore Console

Firebase cung cấp query tool:
1. Firebase Console → Firestore
2. Click "Start collection query"
3. Viết query:

```javascript
// Get all active reviews
db.collection('reviews')
  .where('isActive', '==', true)
  .orderBy('createdAt', 'desc')
  .limit(10)
  .get()
```

### 3. Query từ Backend Log

Khi bạn call API, backend có thể log Firestore queries:

```typescript
// Thêm vào firestore-reviews.service.ts
console.log('Firestore Query:', {
  collection: 'reviews',
  filters: { productId, isActive: true },
  orderBy: 'createdAt DESC',
  limit: 10
});
```

---

## 📈 Performance Testing

### 1. Load Testing - Tạo Nhiều Reviews

```bash
#!/bin/bash
# save as test-load.sh

for i in {1..100}; do
  curl -X POST http://localhost:5000/api/reviews \
    -H "Authorization: Bearer $JWT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
      \"productId\": \"$PRODUCT_ID\",
      \"rating\": $((1 + RANDOM % 5)),
      \"comment\": \"Review number $i - Great product!\"
    }"
  sleep 0.1  # Slow down requests
done
```

**Kiểm tra**:
- ✅ Tất cả 100 reviews được tạo
- ✅ Firestore shows 100 documents
- ✅ Average rating được tính đúng

### 2. Query Performance

```javascript
// Test pagination
GET /api/reviews?page=1&limit=10
GET /api/reviews?page=2&limit=10
GET /api/reviews?page=10&limit=10

// Check response time in Postman/Thunder Client
// Firestore should return results in < 500ms
```

### 3. Concurrent Requests

```bash
# 10 concurrent review creations
for i in {1..10}; do
  (curl -X POST http://localhost:5000/api/reviews -H "..." -d "...") &
done
wait
```

---

## ⚠️ Error Testing

### 1. Create Duplicate Review (Should Fail)

```http
POST /api/reviews
Authorization: Bearer {jwt_token}
Content-Type: application/json

REQUEST:
{
  "productId": "{same_product_id_as_before}",
  "rating": 3,
  "comment": "Second review"
}

RESPONSE (400):
{
  "statusCode": 400,
  "message": "You have already reviewed this product",
  "error": "Bad Request"
}

✅ Firestore check: User can only review product once
```

### 2. Update Someone Else's Review (Should Fail)

```http
PATCH /api/reviews/{another_users_review_id}
Authorization: Bearer {my_jwt_token}
Content-Type: application/json

REQUEST:
{
  "rating": 1
}

RESPONSE (403):
{
  "statusCode": 403,
  "message": "You can only update your own reviews",
  "error": "Forbidden"
}

✅ Firestore security check: ownership verification
```

### 3. Invalid Product ID (Should Fail)

```http
POST /api/reviews
Authorization: Bearer {jwt_token}
Content-Type: application/json

REQUEST:
{
  "productId": "non-existent-id",
  "rating": 5,
  "comment": "Test"
}

RESPONSE (404):
{
  "statusCode": 404,
  "message": "Product not found",
  "error": "Not Found"
}

✅ PostgreSQL validation: product existence check
```

### 4. Invalid Rating (Should Fail)

```http
POST /api/reviews
Authorization: Bearer {jwt_token}
Content-Type: application/json

REQUEST:
{
  "productId": "{product_id}",
  "rating": 10,  // Invalid: must be 1-5
  "comment": "Test"
}

RESPONSE (400):
{
  "statusCode": 400,
  "message": "Rating must be between 1 and 5",
  "error": "Bad Request"
}

✅ Data validation: DTO validation
```

---

## 📋 Test Checklist

### Basic CRUD Operations
- [ ] POST /api/reviews - Create review
- [ ] GET /api/reviews - List reviews (admin)
- [ ] GET /api/reviews/{id} - Get single review
- [ ] PATCH /api/reviews/{id} - Update review (user)
- [ ] DELETE /api/reviews/{id} - Delete review (user)

### Product-Related
- [ ] GET /api/reviews/product/{productId} - Get product reviews
- [ ] GET /api/reviews/product/{productId}/stats - Get product stats

### User-Related
- [ ] GET /api/reviews/my-reviews - Get user's reviews

### Admin Operations
- [ ] PATCH /api/reviews/{id}/verify - Verify review (admin)
- [ ] DELETE /api/reviews/{id}/admin - Delete review (admin)
- [ ] GET /api/reviews/stats - Get overall stats (admin)

### Security
- [ ] Duplicate review check
- [ ] Ownership verification
- [ ] Product existence check
- [ ] Rating validation
- [ ] Authentication check

### Firestore Data
- [ ] Data appears in Firestore console
- [ ] Timestamps are correct
- [ ] isActive flag works
- [ ] Soft delete functionality
- [ ] Stats calculation accuracy

---

## 🐛 Debugging Tips

### 1. Enable Debug Logging

```typescript
// Add to firestore-reviews.service.ts
private logger = new Logger('FirestoreReviewsService');

async createReview(...) {
  this.logger.debug('Creating review', { userId, productId, rating });
  // ... rest of code
}
```

### 2. Backend Logs

```bash
# Running backend
npm run start:dev

# Look for:
# ✅ Firebase initialized successfully
# 📝 Creating review {details}
# ✅ Review created with ID: {id}
```

### 3. Firebase Console Logs

```
Firebase Console
  ↓
Project Settings
  ↓
Logging → Enable Debug Logging
```

### 4. Network Tab (Browser Console)

If testing from frontend:
1. Open DevTools (F12)
2. Network tab
3. Look at Firestore API calls
4. Check response status and payload

---

## 📊 Expected Results Summary

| Operation | Source | Storage | Status |
|-----------|--------|---------|--------|
| Create Review | API | Firestore | ✅ Works |
| Read Review | API | Firestore | ✅ Works |
| Update Review | API | Firestore | ✅ Works |
| Delete Review | API | Firestore | ✅ Works (Soft) |
| Product Stats | Firestore | Firestore | ✅ Works |
| Update Product Rating | PostgreSQL | Hybrid | ✅ Works |
| User Enrichment | PostgreSQL | PostgreSQL | ✅ Works |
| Firestore Backup | Firestore | Firestore | ✅ Auto |
| Security Rules | Firestore | Firestore | ✅ Enforced |

---

## 📞 Troubleshooting Common Issues

**Issue**: Firestore not initializing
```
Error: Firebase app initialization failed
```
**Solution**: Check .env file has all FIREBASE_* variables

---

**Issue**: Permission Denied on Firestore
```
Error: Missing or insufficient permissions
```
**Solution**: Check Firestore security rules deployed correctly

---

**Issue**: Reviews not appearing in Firestore
```
No documents in /reviews collection
```
**Solution**: Check backend logs for errors, ensure POST request succeeded

---

**Issue**: Update timestamp not changing
```
updatedAt is same as before
```
**Solution**: Verify firestore-reviews.service.ts has `updatedAt: admin.firestore.Timestamp.now()`

---

**Version**: 1.0  
**Last Updated**: 2025-01-15  
**Status**: ✅ Complete
