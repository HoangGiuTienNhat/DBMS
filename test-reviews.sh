#!/bin/bash
# Script to test Reviews API endpoints

API_URL="http://localhost:5000/api/reviews"

echo "Testing Reviews API Endpoints..."
echo "================================"

# Test 1: GET product reviews (no auth needed)
echo -e "\n1. GET /api/reviews/product/{productId}"
curl -X GET "http://localhost:5000/api/reviews/product/a0eebc99-9c0b-4ef8-bb6d-6662c6c14223" \
  -H "Content-Type: application/json"

# Test 2: GET product stats (no auth needed)
echo -e "\n\n2. GET /api/reviews/product/{productId}/stats"
curl -X GET "http://localhost:5000/api/reviews/product/a0eebc99-9c0b-4ef8-bb6d-6662c6c14223/stats" \
  -H "Content-Type: application/json"
