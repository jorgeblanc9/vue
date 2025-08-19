#!/bin/bash

# Script Name: Testing Suite
# Purpose: Run tests with multiple modes and options
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

log_info "🧪 Starting Vue 3 + Vite Testing Environment"

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

# Parse command line arguments
TEST_MODE=${1:-"run"}

case $TEST_MODE in
    "run")
        log_info "🏃 Running tests..."
        npm run test:run
        ;;
    "watch")
        log_info "👀 Running tests in watch mode..."
        npm run test:watch
        ;;
    "ui")
        log_info "🖥️  Opening test UI..."
        npm run test:ui
        ;;
    "coverage")
        log_info "📊 Running tests with coverage..."
        npm run test:coverage
        ;;
    *)
        log_error "Unknown test mode: $TEST_MODE"
        log_info "Available modes: run, watch, ui, coverage"
        log_info "Usage: ./script/test.sh [run|watch|ui|coverage]"
        exit 1
        ;;
esac
