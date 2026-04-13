#!/usr/bin/env node

// Simple test without http module
const https = require('https');
const http = require('http');
const url = require('url');

const testPayload = {
  productId: 'a0eebc99-9c0b-4ef8-bb6d-000000000001',
  rating: 5,
  comment: 'Excellent product quality!',
};

// Minimal JWT token (will likely fail auth but will test API routing)
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJzdWIiOiI0YTVhYzY2ZC00YmM5LTRjMDEtODM1NC05M2I2NDZiZDgwMTAiLCJyb2xlIjoidXNlciIsImlhdCI6MTc3NjA5MTUyMCwiZXhwIjoxNzc4NjgzNTIwfQ.test';

const urlObj = new URL('http://localhost:5000/api/reviews');
const postData = JSON.stringify(testPayload);

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/reviews',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(postData),
    'Authorization': `Bearer ${token}`,
  },
};

console.log('📝 Testing Reviews API POST Endpoint\n');
console.log('Endpoint: POST http://localhost:5000/api/reviews');
console.log('Payload:');
console.log(JSON.stringify(testPayload, null, 2));
console.log('\nFull Firestore integration (NO PostgreSQL fallback)\n');
console.log('Sending request...\n');

const req = http.request(options, (res) => {
  let data = '';

  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    console.log(`========== RESPONSE ==========`);
    console.log(`Status Code: ${res.statusCode}`);
    console.log(`Status: ${res.statusMessage}`);
    console.log(`\nResponse Body:`);
    
    try {
      const json = JSON.parse(data);
      console.log(JSON.stringify(json, null, 2));
      
      if (res.statusCode >= 200 && res.statusCode < 300) {
        console.log(`\n✅ SUCCESS: Review saved to Firestore!`);
        console.log(`Review ID: ${json.id}`);
      } else if (res.statusCode === 401) {
        console.log(`\n⚠️ Unauthorized - Invalid/expired token`);
        console.log(`You need a valid JWT token to create reviews`);
      } else {
        console.log(`\n❌ Error: ${json.message || 'Unknown error'}`);
      }
    } catch (e) {
      console.log(data);
    }
    console.log(`==============================\n`);
  });
});

req.on('error', (e) => {
  console.error(`❌ Request failed: ${e.message}`);
  process.exit(1);
});

req.write(postData);
req.end();
