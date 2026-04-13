"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const axios_1 = __importDefault(require("axios"));
const BASE_URL = 'http://localhost:3000/api';
const TEST_TOKEN = 'your-jwt-token-here';
async function testCreateReview() {
    try {
        console.log('\n📝 Testing CREATE REVIEW API...\n');
        const response = await axios_1.default.post(`${BASE_URL}/reviews`, {
            productId: 'a0eebc99-9c0b-4ef8-bb6d-000000000001',
            rating: 4,
            comment: 'Great product! Very satisfied with the quality.',
        }, {
            headers: {
                'Authorization': `Bearer ${TEST_TOKEN}`,
                'Content-Type': 'application/json',
            },
        });
        console.log('✅ Success Response:');
        console.log(JSON.stringify(response.data, null, 2));
    }
    catch (error) {
        console.error('❌ Error Response:');
        console.error('Status:', error.response?.status);
        console.error('Data:', JSON.stringify(error.response?.data, null, 2));
        console.error('Message:', error.message);
    }
}
testCreateReview();
//# sourceMappingURL=test-reviews-api.js.map