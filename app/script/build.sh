#!/bin/bash

# Script Name: Build Production
# Purpose: Build production version with optimization
# Author: Development Team
# Date: 2024-01-01
# Version: 1.0.0

set -e  # Exit on any error
set -u  # Exit on undefined variables

# Logging functions
log_info() {
    echo "ℹ️  $1"
}

log_success() {
    echo "✅ $1"
}

log_error() {
    echo "❌ $1"
}

log_warning() {
    echo "⚠️  $1"
}

# Error handler
error_handler() {
    log_error "Error occurred in script at line $1"
    exit 1
}

trap 'error_handler $LINENO' ERR

log_info "🏗️  Starting Vue 3 + Vite Production Build"

# Load nvm and use correct Node version
log_info "📦 Loading Node.js version from .nvmrc..."
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use

# Verify correct version
EXPECTED_VERSION="v22.18.0"
CURRENT_VERSION=$(node --version)

if [ "$CURRENT_VERSION" != "$EXPECTED_VERSION" ]; then
    log_error "Wrong Node.js version detected"
    log_error "Expected: $EXPECTED_VERSION"
    log_error "Current:  $CURRENT_VERSION"
    log_error "Please run: nvm use"
    exit 1
fi

log_success "Node.js version: $CURRENT_VERSION"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    log_info "📦 Installing dependencies..."
    npm install
else
    log_success "Dependencies already installed"
fi

# Clean previous build
if [ -d "dist" ]; then
    log_info "🧹 Cleaning previous build..."
    rm -rf dist
    log_success "Previous build cleaned"
fi

# Run tests before build
log_info "🧪 Running tests before build..."
npm run test:run
log_success "All tests passed"

# Build production version
log_info "🏗️  Building production version..."
npm run build

# Check if build was successful
if [ -d "dist" ]; then
    log_success "Build completed successfully!"
    log_info "📁 Build output: dist/"
    
    # Show build size
    BUILD_SIZE=$(du -sh dist | cut -f1)
    log_info "📊 Build size: $BUILD_SIZE"
else
    log_error "Build failed - dist directory not found"
    exit 1
fi

log_success "🎉 Production build completed successfully!"
