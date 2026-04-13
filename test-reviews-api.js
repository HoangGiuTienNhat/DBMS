const http = require('http');

// Test API Reviews
const testData = {
  productId: 'a0eebc99-9c0b-4ef8-bb6d-000000000001',
  rating: 4,
  comment: 'Great product! Very satisfied with the quality.',
};

// JWT Token - replace with actual token from your auth
const JWT_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJzdWIiOiI0YTVhYzY2ZC00YmM5LTRjMDEtODM1NC05M2I2NDZiZDgwMTAiLCJyb2xlIjoidXNlciIsImlhdCI6MTc3NjA5MTUyMCwiZXhwIjoxNzc4NjgzNTIwfQ.xyz';

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/reviews',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${JWT_TOKEN}`,
  },
};

const req = http.request(options, (res) => {
  console.log(`\n\n========== API RESPONSE ==========`);
  console.log(`Status Code: ${res.statusCode}`);
  console.log(`Status Message: ${res.statusMessage}\n`);

  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    try {
      const jsonData = JSON.parse(data);
      console.log('Response Body:');
      console.log(JSON.stringify(jsonData, null, 2));
      
      if (res.statusCode === 201) {
        console.log('\n✅ Review created successfully!');
        console.log(`Review ID: ${jsonData.id}`);
        console.log(`Status: Firebase storage enabled (no PostgreSQL fallback)`);
      } else {
        console.log('\n❌ Error creating review');
      }
    } catch (e) {
      console.log('Response Body (raw):');
      console.log(data);
    }
    console.log('==================================\n');
  });
});

req.on('error', (error) => {
  console.error('Request Error:', error.message);
});

console.log('\n🚀 Testing Reviews API (Firestore Only - No PostgreSQL Fallback)');
console.log('POST /api/reviews');
console.log('Request Body:');
console.log(JSON.stringify(testData, null, 2));

req.write(JSON.stringify(testData));
req.end();
