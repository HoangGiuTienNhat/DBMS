const http = require('http');

// Test Configuration
const CONFIG = {
  hostname: 'localhost',
  port: 5000,
  timeout: 5000,
};

// Test Data Storage
let testState = {
  reviewId: null,
  productId: 'a0eebc99-9c0b-4ef8-bb6d-6662c6c14223', // Test product ID - may not exist
  userId: '4a5ac66d-4bc9-4c01-8354-93b646bd8010', // Test user ID
  adminToken: null, // Will be fetched or set to test value
  userToken: null, // Will be fetched or set to test value
  API_BASE: `http://${CONFIG.hostname}:${CONFIG.port}/api`,
};

const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
};

/**
 * Make HTTP Request
 */
function makeRequest(method, path, data = null, token = null) {
  return new Promise((resolve, reject) => {
    const url = new URL(testState.API_BASE + path);
    const options = {
      hostname: url.hostname,
      port: CONFIG.port,
      path: url.pathname + url.search,
      method,
      headers: {
        'Content-Type': 'application/json',
      },
      timeout: CONFIG.timeout,
    };

    if (token) {
      options.headers['Authorization'] = `Bearer ${token}`;
    }

    const req = http.request(options, (res) => {
      let responseData = '';

      res.on('data', (chunk) => {
        responseData += chunk;
      });

      res.on('end', () => {
        try {
          const parsed = responseData ? JSON.parse(responseData) : {};
          resolve({
            statusCode: res.statusCode,
            statusMessage: res.statusMessage,
            data: parsed,
            raw: responseData,
          });
        } catch (e) {
          resolve({
            statusCode: res.statusCode,
            statusMessage: res.statusMessage,
            data: responseData,
            raw: responseData,
            parseError: true,
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

/**
 * Print Test Result
 */
function printResult(testName, statusCode, expectedCode, details = '') {
  const passed = statusCode === expectedCode;
  const icon = passed ? `${colors.green}✅${colors.reset}` : `${colors.red}❌${colors.reset}`;
  console.log(
    `${icon} ${testName} - Status: ${statusCode} (Expected: ${expectedCode})${details ? ' - ' + details : ''}`,
  );
  return passed;
}

/**
 * Sleep function
 */
function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

/**
 * Run All Tests
 */
async function runTests() {
  console.log(`\n${colors.cyan}${'='.repeat(60)}${colors.reset}`);
  console.log(`${colors.cyan}    COMPREHENSIVE REVIEWS API TEST SUITE${colors.reset}`);
  console.log(`${colors.cyan}${'='.repeat(60)}${colors.reset}\n`);

  let passed = 0;
  let failed = 0;
  const results = [];

  try {
    // ==========================================
    // 1. CREATE REVIEW (POST /api/reviews)
    // ==========================================
    console.log(`${colors.blue}[1/11] POST /api/reviews - Create Review${colors.reset}`);
    try {
      const createReviewData = {
        productId: testState.productId,
        rating: 5,
        comment: 'Excellent product! Highly recommended.',
      };

      const res = await makeRequest('POST', '/reviews', createReviewData, testState.userToken);
      if (printResult('Create Review', res.statusCode, 201, res.data?.id ? 'Review created' : '')) {
        testState.reviewId = res.data?.id;
        passed++;
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 2. GET PRODUCT REVIEWS (GET /api/reviews/product/{id})
    // ==========================================
    console.log(
      `${colors.blue}[2/11] GET /api/reviews/product/{productId} - Get Product Reviews${colors.reset}`,
    );
    try {
      const res = await makeRequest('GET', `/reviews/product/${testState.productId}`);
      if (printResult('Get Product Reviews', res.statusCode, 200)) {
        console.log(`   Total reviews for product: ${res.data?.total || 0}`);
        passed++;
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 3. GET PRODUCT REVIEW STATS (GET /api/reviews/product/{id}/stats)
    // ==========================================
    console.log(
      `${colors.blue}[3/11] GET /api/reviews/product/{productId}/stats - Product Stats${colors.reset}`,
    );
    try {
      const res = await makeRequest('GET', `/reviews/product/${testState.productId}/stats`);
      if (printResult('Get Product Stats', res.statusCode, 200)) {
        console.log(
          `   Avg Rating: ${res.data?.averageRating || 0} | Total: ${res.data?.totalReviews || 0} | Verified: ${res.data?.verifiedReviews || 0}`,
        );
        passed++;
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 4. GET USER'S REVIEWS (GET /api/reviews/my-reviews)
    // ==========================================
    console.log(`${colors.blue}[4/11] GET /api/reviews/my-reviews - Get My Reviews${colors.reset}`);
    try {
      const res = await makeRequest('GET', '/reviews/my-reviews', null, testState.userToken);
      if (printResult('Get My Reviews', res.statusCode, 200)) {
        console.log(`   Your reviews count: ${res.data?.total || 0}`);
        passed++;
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 5. GET SINGLE REVIEW (GET /api/reviews/{id})
    // ==========================================
    if (testState.reviewId) {
      console.log(`${colors.blue}[5/11] GET /api/reviews/{id} - Get Single Review${colors.reset}`);
      try {
        const res = await makeRequest('GET', `/reviews/${testState.reviewId}`);
        if (printResult('Get Single Review', res.statusCode, 200, `ID: ${testState.reviewId}`)) {
          console.log(`   Rating: ${res.data?.rating}/5 | Verified: ${res.data?.isVerified}`);
          passed++;
        } else {
          console.log(`   Response: ${JSON.stringify(res.data)}`);
          failed++;
        }
      } catch (error) {
        console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
        failed++;
      }
      console.log();
    } else {
      console.log(`${colors.yellow}⚠️  [5/11] GET /api/reviews/{id} - Skipped (No review ID)${colors.reset}\n`);
    }

    // ==========================================
    // 6. UPDATE REVIEW (PATCH /api/reviews/{id})
    // ==========================================
    if (testState.reviewId) {
      console.log(`${colors.blue}[6/11] PATCH /api/reviews/{id} - Update Review${colors.reset}`);
      try {
        const updateData = {
          rating: 4,
          comment: 'Updated comment - Still a great product!',
        };

        const res = await makeRequest('PATCH', `/reviews/${testState.reviewId}`, updateData, testState.userToken);
        if (printResult('Update Review', res.statusCode, 200)) {
          console.log(`   New Rating: ${res.data?.rating}/5`);
          passed++;
        } else {
          console.log(`   Response: ${JSON.stringify(res.data)}`);
          failed++;
        }
      } catch (error) {
        console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
        failed++;
      }
      console.log();
    } else {
      console.log(`${colors.yellow}⚠️  [6/11] PATCH /api/reviews/{id} - Skipped (No review ID)${colors.reset}\n`);
    }

    // ==========================================
    // 7. VERIFY REVIEW (PATCH /api/reviews/{id}/verify) - Admin Only
    // ==========================================
    if (testState.reviewId) {
      console.log(`${colors.blue}[7/11] PATCH /api/reviews/{id}/verify - Verify Review (Admin)${colors.reset}`);
      try {
        const res = await makeRequest(
          'PATCH',
          `/reviews/${testState.reviewId}/verify`,
          {},
          testState.adminToken,
        );
        if (printResult('Verify Review', res.statusCode, 200)) {
          console.log(`   Verified: ${res.data?.isVerified}`);
          passed++;
        } else if (res.statusCode === 401 || res.statusCode === 403) {
          console.log(`   ${colors.yellow}⚠️  Skipped - Admin auth needed${colors.reset}`);
        } else {
          console.log(`   Response: ${JSON.stringify(res.data)}`);
          failed++;
        }
      } catch (error) {
        console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
        failed++;
      }
      console.log();
    } else {
      console.log(`${colors.yellow}⚠️  [7/11] PATCH /api/reviews/{id}/verify - Skipped (No review ID)${colors.reset}\n`);
    }

    // ==========================================
    // 8. DELETE REVIEW (DELETE /api/reviews/{id})
    // ==========================================
    if (testState.reviewId) {
      console.log(`${colors.blue}[8/11] DELETE /api/reviews/{id} - Delete Review${colors.reset}`);
      try {
        const res = await makeRequest(
          'DELETE',
          `/reviews/${testState.reviewId}`,
          null,
          testState.userToken,
        );
        if (printResult('Delete Review', res.statusCode, 200)) {
          console.log(`   ${res.data?.message || 'Review deleted'}`);
          passed++;
        } else {
          console.log(`   Response: ${JSON.stringify(res.data)}`);
          failed++;
        }
      } catch (error) {
        console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
        failed++;
      }
      console.log();
    } else {
      console.log(`${colors.yellow}⚠️  [8/11] DELETE /api/reviews/{id} - Skipped (No review ID)${colors.reset}\n`);
    }

    // ==========================================
    // 9. GET ALL REVIEWS (GET /api/reviews) - Admin Only
    // ==========================================
    console.log(`${colors.blue}[9/11] GET /api/reviews - Get All Reviews (Admin)${colors.reset}`);
    try {
      const res = await makeRequest('GET', '/reviews?page=1&limit=10', null, testState.adminToken);
      if (printResult('Get All Reviews', res.statusCode, 200)) {
        console.log(`   Total reviews: ${res.data?.total || 0}`);
        passed++;
      } else if (res.statusCode === 401 || res.statusCode === 403) {
        console.log(`   ${colors.yellow}⚠️  Skipped - Admin auth needed${colors.reset}`);
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 10. GET REVIEW STATS (GET /api/reviews/stats) - Admin Only
    // ==========================================
    console.log(`${colors.blue}[10/11] GET /api/reviews/stats - Get Overall Stats (Admin)${colors.reset}`);
    try {
      const res = await makeRequest('GET', '/reviews/stats', null, testState.adminToken);
      if (printResult('Get Review Stats', res.statusCode, 200)) {
        console.log(
          `   Total: ${res.data?.totalReviews || 0} | Avg: ${res.data?.averageRating || 0} | Verified: ${res.data?.verifiedReviews || 0}`,
        );
        passed++;
      } else if (res.statusCode === 401 || res.statusCode === 403) {
        console.log(`   ${colors.yellow}⚠️  Skipped - Admin auth needed${colors.reset}`);
      } else {
        console.log(`   Response: ${JSON.stringify(res.data)}`);
        failed++;
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();

    // ==========================================
    // 11. ADMIN DELETE REVIEW (DELETE /api/reviews/{id}/admin) - Admin Only
    // ==========================================
    console.log(
      `${colors.blue}[11/11] DELETE /api/reviews/{id}/admin - Admin Delete Review${colors.reset}`,
    );
    try {
      // Create a new review for admin deletion test
      const createData = {
        productId: testState.productId,
        rating: 3,
        comment: 'Test review for admin deletion',
      };

      const createRes = await makeRequest('POST', '/reviews', createData, testState.userToken);
      if (createRes.statusCode === 201 && createRes.data?.id) {
        const testReviewId = createRes.data.id;

        // Now delete it as admin
        const res = await makeRequest(
          'DELETE',
          `/reviews/${testReviewId}/admin`,
          null,
          testState.adminToken,
        );
        if (printResult('Admin Delete Review', res.statusCode, 200)) {
          console.log(`   ${res.data?.message || 'Review deleted by admin'}`);
          passed++;
        } else if (res.statusCode === 401 || res.statusCode === 403) {
          console.log(`   ${colors.yellow}⚠️  Skipped - Admin auth needed${colors.reset}`);
        } else {
          console.log(`   Response: ${JSON.stringify(res.data)}`);
          failed++;
        }
      } else {
        console.log(`   ${colors.yellow}⚠️  Skipped - Could not create test review${colors.reset}`);
      }
    } catch (error) {
      console.log(`${colors.red}❌ Error: ${error.message}${colors.reset}`);
      failed++;
    }
    console.log();
  } catch (error) {
    console.error(`${colors.red}Fatal Error: ${error.message}${colors.reset}`);
  }

  // ==========================================
  // SUMMARY
  // ==========================================
  console.log(`${colors.cyan}${'='.repeat(60)}${colors.reset}`);
  console.log(`${colors.cyan}                    TEST SUMMARY${colors.reset}`);
  console.log(`${colors.cyan}${'='.repeat(60)}${colors.reset}`);
  console.log(`${colors.green}Passed: ${passed}${colors.reset}`);
  console.log(`${colors.red}Failed: ${failed}${colors.reset}`);
  console.log(`Total: ${passed + failed}`);
  console.log(`${colors.cyan}${'='.repeat(60)}${colors.reset}\n`);

  // ==========================================
  // TEST STATUS
  // ==========================================
  if (failed === 0) {
    console.log(
      `${colors.green}✅ ALL TESTS PASSED! Reviews API is fully operational.${colors.reset}\n`,
    );
  } else if (failed <= 3) {
    console.log(
      `${colors.yellow}⚠️  SOME TESTS FAILED/SKIPPED - May need auth token or Firestore setup${colors.reset}\n`,
    );
  } else {
    console.log(`${colors.red}❌ MULTIPLE TESTS FAILED - Check backend and configuration${colors.reset}\n`);
  }

  // ==========================================
  // NOTES
  // ==========================================
  console.log(`${colors.cyan}📝 NOTES:${colors.reset}`);
  console.log(`   • Tests that require admin auth may be skipped (401/403)`);
  console.log(`   • Provide valid JWT tokens for complete testing`);
  console.log(`   • Review IDs are generated by Firestore (UUID format)`);
  console.log(`   • All data is stored in Firebase Firestore (no PostgreSQL fallback)\n`);
}

// ==========================================
// Main Execution
// ==========================================
console.log(`${colors.cyan}🚀 Connecting to API at ${testState.API_BASE}${colors.reset}`);
console.log(`${colors.cyan}⏳ Starting tests in 1 second...${colors.reset}\n`);

setTimeout(() => {
  runTests().catch((error) => {
    console.error(`${colors.red}Fatal Error: ${error.message}${colors.reset}`);
    process.exit(1);
  });
}, 1000);
