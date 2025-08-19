import { config } from '@vue/test-utils'

// Global Vue Test Utils configuration
config.global.stubs = {
    // Global component stubs
}

// Global test utilities
global.ResizeObserver = class ResizeObserver {
    observe() { }
    unobserve() { }
    disconnect() { }
}

// Mock console methods to reduce noise in tests
const originalConsoleError = console.error
const originalConsoleWarn = console.warn

beforeEach(() => {
    console.error = vi.fn()
    console.warn = vi.fn()
})

afterEach(() => {
    console.error = originalConsoleError
    console.warn = originalConsoleWarn
})
