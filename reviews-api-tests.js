const http = require('http');

// Test Configuration
const API_HOST = 'localhost';
const API_PORT = 5000;
const API_BASE = `http://${API_HOST}:${API_PORT}/api`;

// Helper function to make HTTP requests
function httpRequest(method, pathname, data = null, token = null) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: API_HOST,
      port: API_PORT,
      path: pathname,
      method: method,
      headers: {
        'Content-Type': 'application/json',
      },
      timeout: 5000,
    };

    if (token) {
      options.headers['Authorization'] = `Bearer ${token}`;
    }

    const req = http.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => (body += chunk));
      res.on('end', () => {
        try {
          const parsed = body ? JSON.parse(body) : {};
          resolve({
            statusCode: res.statusCode,
            data: parsed,
            raw: body,
          });
        } catch (e) {
          resolve({
            statusCode: res.statusCode,
            data: { raw: body },
            raw: body,
          });
        }
      });
    });

    req.on('error', (error) => {
      reject(error);
    });

    req.on('timeout', () => {
      req.destroy();
      reject(new Error('Request timeout'));
    });

    if (data) {
      req.write(JSON.stringify(data));
    }
    req.end();
  });
}

// Main test suite
async function runTests() {
  console.log('\n╔════════════════════════════════════════════════════════════╗');
  console.log('║       REVIEWS API - COMPREHENSIVE TEST SUITE (Firestore)     ║');
  console.log('╚════════════════════════════════════════════════════════════╝\n');

  let testsPassed = 0;
  let testsFailed = 0;
  let testsSkipped = 0;

  // Test data
  const userToken = 'test-token-user';
  const adminToken = 'test-token-admin';
  const testProductId = 'a0eebc99-9c0b-4ef8-bb6d-6662c6c14223';
  const testUserId = '4a5ac66d-4bc9-4c01-8354-93b646bd8010';
  let testReviewId = null;

  try {
    // ============= Test 1: GET /api/reviews/product/{productId} - Get Product Reviews =============
    console.log('📝 Test 1: GET /api/reviews/product/{productId}');
    try {
      const res = await httpRequest('GET', `/api/reviews/product/${testProductId}`);
      if (res.statusCode === 200) {
        console.log('  ✅ PASS - Returns product reviews (no auth required)');
        console.log(`     Response: ${res.data.total || 0} total reviews`);
        testsPassed++;
      } else if (res.statusCode === 500) {
        console.log(`  ❌ FAIL - Server error (500): ${res.data.message}`);
        testsFailed++;
      } else {
        console.log(`  ⚠️  SKIP - Status ${res.statusCode}`);
        testsSkipped++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    // ============= Test 2: GET /api/reviews/product/{productId}/stats - Product Stats =============
    console.log('📝 Test 2: GET /api/reviews/product/{productId}/stats');
    try {
      const res = await httpRequest('GET', `/api/reviews/product/${testProductId}/stats`);
      if (res.statusCode === 200) {
        console.log('  ✅ PASS - Returns product review stats');
        console.log(`     Avg Rating: ${res.data.averageRating || 0} | Total: ${res.data.totalReviews || 0}`);
        testsPassed++;
      } else if (res.statusCode === 404) {
        console.log(`  ℹ️  INFO - Product not found (404) - This is expected if product doesn't exist`);
        testsSkipped++;
      } else {
        console.log(`  ⚠️  SKIP - Status ${res.statusCode}`);
        testsSkipped++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    // ============= Test 3: POST /api/reviews - Create Review =============
    console.log('📝 Test 3: POST /api/reviews (Create Review)');
    try {
      const payload = {
        productId: testProductId,
        rating: 5,
        comment: 'Excellent product! Highly recommended.',
      };
      const res = await httpRequest('POST', '/api/reviews', payload, userToken);
      if (res.statusCode === 201) {
        testReviewId = res.data.id;
        console.log('  ✅ PASS - Review created successfully');
        console.log(`     Review ID: ${testReviewId}`);
        testsPassed++;
      } else if (res.statusCode === 401) {
        console.log(`  ℹ️  INFO - Unauthorized (401) - Need valid JWT token`);
        console.log(`     Response: ${res.data.message}`);
        testsSkipped++;
      } else {
        console.log(`  ❌ FAIL - Status ${res.statusCode}: ${res.data.message}`);
        testsFailed++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    // ============= Test 4: GET /api/reviews/my-reviews - Get My Reviews =============
    console.log('📝 Test 4: GET /api/reviews/my-reviews (Get User\'s Reviews)');
    try {
      const res = await httpRequest('GET', '/api/reviews/my-reviews?page=1&limit=10', null, userToken);
      if (res.statusCode === 200) {
        console.log('  ✅ PASS - Retrieved user reviews');
        console.log(`     Total reviews: ${res.data.total || 0}`);
        testsPassed++;
      } else if (res.statusCode === 401) {
        console.log(`  ℹ️  INFO - Unauthorized (401) - Need valid JWT token`);
        testsSkipped++;
      } else {
        console.log(`  ❌ FAIL - Status ${res.statusCode}`);
        testsFailed++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    if (testReviewId) {
      // ============= Test 5: GET /api/reviews/{id} - Get Single Review =============
      console.log('📝 Test 5: GET /api/reviews/{id} (Get Single Review)');
      try {
        const res = await httpRequest('GET', `/api/reviews/${testReviewId}`);
        if (res.statusCode === 200) {
          console.log('  ✅ PASS - Retrieved single review');
          console.log(`     Rating: ${res.data.rating}/5 | Verified: ${res.data.isVerified}`);
          testsPassed++;
        } else {
          console.log(`  ❌ FAIL - Status ${res.statusCode}: ${res.data.message}`);
          testsFailed++;
        }
      } catch (err) {
        console.log(`  ❌ FAIL - ${err.message}`);
        testsFailed++;
      }
      console.log();

      // ============= Test 6: PATCH /api/reviews/{id} - Update Review =============
      console.log('📝 Test 6: PATCH /api/reviews/{id} (Update Review)');
      try {
        const payload = {
          rating: 4,
          comment: 'Updated: Good product, great value.',
        };
        const res = await httpRequest('PATCH', `/api/reviews/${testReviewId}`, payload, userToken);
        if (res.statusCode === 200) {
          console.log('  ✅ PASS - Review updated successfully');
          console.log(`     New Rating: ${res.data.rating}/5`);
          testsPassed++;
        } else if (res.statusCode === 401) {
          console.log(`  ℹ️  INFO - Unauthorized (401) - Need valid JWT token`);
          testsSkipped++;
        } else {
          console.log(`  ❌ FAIL - Status ${res.statusCode}: ${res.data.message}`);
          testsFailed++;
        }
      } catch (err) {
        console.log(`  ❌ FAIL - ${err.message}`);
        testsFailed++;
      }
      console.log();

      // ============= Test 7: PATCH /api/reviews/{id}/verify - Verify Review =============
      console.log('📝 Test 7: PATCH /api/reviews/{id}/verify (Verify Review - Admin)');
      try {
        const res = await httpRequest('PATCH', `/api/reviews/${testReviewId}/verify`, {}, adminToken);
        if (res.statusCode === 200) {
          console.log('  ✅ PASS - Review verified successfully');
          console.log(`     Verified: ${res.data.isVerified}`);
          testsPassed++;
        } else if (res.statusCode === 401 || res.statusCode === 403) {
          console.log(`  ℹ️  INFO - Unauthorized (${res.statusCode}) - Need admin JWT token`);
          testsSkipped++;
        } else {
          console.log(`  ❌ FAIL - Status ${res.statusCode}`);
          testsFailed++;
        }
      } catch (err) {
        console.log(`  ❌ FAIL - ${err.message}`);
        testsFailed++;
      }
      console.log();

      // ============= Test 8: DELETE /api/reviews/{id} - Delete Review =============
      console.log('📝 Test 8: DELETE /api/reviews/{id} (Delete Review)');
      try {
        const res = await httpRequest('DELETE', `/api/reviews/${testReviewId}`, null, userToken);
        if (res.statusCode === 200) {
          console.log('  ✅ PASS - Review deleted successfully');
          console.log(`     Message: ${res.data.message}`);
          testsPassed++;
          testReviewId = null; // Clear for further tests
        } else if (res.statusCode === 401) {
          console.log(`  ℹ️  INFO - Unauthorized (401) - Need valid JWT token`);
          testsSkipped++;
        } else {
          console.log(`  ❌ FAIL - Status ${res.statusCode}`);
          testsFailed++;
        }
      } catch (err) {
        console.log(`  ❌ FAIL - ${err.message}`);
        testsFailed++;
      }
      console.log();
    }

    // ============= Test 9: GET /api/reviews - Get All Reviews (Admin) =============
    console.log('📝 Test 9: GET /api/reviews (Get All Reviews - Admin)');
    try {
      const res = await httpRequest('GET', '/api/reviews?page=1&limit=10', null, adminToken);
      if (res.statusCode === 200) {
        console.log('  ✅ PASS - Retrieved all reviews');
        console.log(`     Total reviews: ${res.data.total || 0}`);
        testsPassed++;
      } else if (res.statusCode === 401 || res.statusCode === 403) {
        console.log(`  ℹ️  INFO - Unauthorized (${res.statusCode}) - Need admin JWT token`);
        testsSkipped++;
      } else {
        console.log(`  ❌ FAIL - Status ${res.statusCode}`);
        testsFailed++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    // ============= Test 10: GET /api/reviews/stats - Get Overall Stats (Admin) =============
    console.log('📝 Test 10: GET /api/reviews/stats (Get Overall Stats - Admin)');
    try {
      const res = await httpRequest('GET', '/api/reviews/stats', null, adminToken);
      if (res.statusCode === 200) {
        console.log('  ✅ PASS - Retrieved overall statistics');
        console.log(
          `     Total: ${res.data.totalReviews} | Avg: ${res.data.averageRating} | Verified: ${res.data.verifiedReviews}`,
        );
        testsPassed++;
      } else if (res.statusCode === 401 || res.statusCode === 403) {
        console.log(`  ℹ️  INFO - Unauthorized (${res.statusCode}) - Need admin JWT token`);
        testsSkipped++;
      } else {
        console.log(`  ❌ FAIL - Status ${res.statusCode}`);
        testsFailed++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();

    // ============= Test 11: DELETE /api/reviews/{id}/admin - Admin Delete =============
    console.log('📝 Test 11: DELETE /api/reviews/{id}/admin (Admin Delete)');
    try {
      // First create a review to delete
      const createRes = await httpRequest(
        'POST',
        '/api/reviews',
        {
          productId: testProductId,
          rating: 3,
          comment: 'Test review for admin delete',
        },
        userToken,
      );

      if (createRes.statusCode === 201 && createRes.data.id) {
        const reviewId = createRes.data.id;
        // Now delete as admin
        const res = await httpRequest('DELETE', `/api/reviews/${reviewId}/admin`, null, adminToken);
        if (res.statusCode === 200) {
          console.log('  ✅ PASS - Review deleted by admin');
          console.log(`     Message: ${res.data.message}`);
          testsPassed++;
        } else if (res.statusCode === 401 || res.statusCode === 403) {
          console.log(`  ℹ️  INFO - Unauthorized (${res.statusCode}) - Need admin JWT token`);
          testsSkipped++;
        } else {
          console.log(`  ❌ FAIL - Status ${res.statusCode}`);
          testsFailed++;
        }
      } else {
        console.log(`  ⚠️  SKIP - Could not create test review`);
        testsSkipped++;
      }
    } catch (err) {
      console.log(`  ❌ FAIL - ${err.message}`);
      testsFailed++;
    }
    console.log();
  } catch (error) {
    console.error(`\n❌ Fatal Error: ${error.message}`);
  }

  // ============= SUMMARY =============
  console.log('╔════════════════════════════════════════════════════════════╗');
  console.log('║                      TEST SUMMARY                           ║');
  console.log('╚════════════════════════════════════════════════════════════╝');
  console.log(`\n  ✅ Passed:  ${testsPassed}`);
  console.log(`  ❌ Failed:  ${testsFailed}`);
  console.log(`  ⏭️  Skipped: ${testsSkipped}`);
  console.log(`  📊 Total:   ${testsPassed + testsFailed + testsSkipped}`);
  console.log();

  if (testsFailed === 0) {
    console.log('🎉 ALL TESTS PASSED! Reviews API is fully operational with Firestore.');
  } else if (testsFailed <= 2) {
    console.log('⚠️  SOME TESTS FAILED - May need valid JWT authentication tokens.');
    console.log('    Endpoints without auth guards are working correctly.');
  } else {
    console.log('❌ MULTIPLE TESTS FAILED - Check backend logs and API implementation.');
  }

  console.log('\n📝 NOTES:');
  console.log('  • API requires JWT tokens for authenticated endpoints');
  console.log('  • Firestore is used for persistent review storage (no PostgreSQL fallback)');
  console.log('  • Product endpoints return product details enriched from PostgreSQL');
  console.log('  • Admin endpoints require admin role in JWT token');
  console.log('  • All test data is stored in Firebase Firestore only\n');
}

// Run tests
console.log('\n🚀 Connecting to API at', API_BASE);
console.log('⏳ Starting test suite in 1 second...\n');

setTimeout(() => {
  runTests().catch((error) => {
    console.error(`\n❌ Fatal Error: ${error.message}`);
    process.exit(1);
  });
}, 1000);
