# Testing Guide - Vue 3 + Vite Project

## Configuración de Testing

Este proyecto utiliza **Vitest** como framework de testing principal, junto con **Vue Test Utils** para testing de componentes Vue.

### Dependencias Instaladas

```json
{
  "devDependencies": {
    "vitest": "^3.2.4",
    "@vitest/ui": "^3.2.4",
    "@vitest/coverage-v8": "^3.2.4",
    "@vue/test-utils": "^2.4.0",
    "jsdom": "^26.1.0"
  }
}
```

## Node.js Version Management
**IMPORTANTE**: Siempre asegura la versión correcta de Node.js antes de ejecutar tests:
```bash
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use
```

## Scripts Disponibles

### Scripts de Testing (Recomendado)
```bash
# Tests básicos con verificación de versión
./test.sh

# Tests en modo watch
./test.sh watch

# Interfaz gráfica de tests
./test.sh ui

# Tests con coverage
./test.sh coverage
```

### NPM Scripts
```bash
# Ejecutar tests en modo watch
npm run test

# Ejecutar tests una vez
npm run test:run

# Ejecutar tests con interfaz gráfica
npm run test:ui

# Ejecutar tests con coverage
npm run test:coverage

# Ejecutar tests en modo watch
npm run test:watch
```

### Makefile Commands
```bash
# Ejecutar tests
make test

# Ejecutar tests en modo watch
make test-watch

# Abrir interfaz gráfica de tests
make test-ui

# Generar reporte de coverage
make test-coverage
```

## Estructura de Tests

```
src/
├── __tests__/
│   ├── setup.js          # Configuración global de tests
│   └── App.test.js       # Tests del componente App
└── components/
    ├── HelloWorld.vue
    └── __tests__/
        └── HelloWorld.test.js  # Tests del componente HelloWorld
```

## Configuración

### Vite Config (`vite.config.js`)
```javascript
export default defineConfig({
  plugins: [vue()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/__tests__/setup.js'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/__tests__/',
        '**/*.d.ts',
        'dist/',
        'coverage/'
      ],
      thresholds: {
        global: {
          branches: 80,
          functions: 80,
          lines: 80,
          statements: 80
        }
      }
    }
  }
})
```

### Setup Global (`src/__tests__/setup.js`)
```javascript
import { config } from '@vue/test-utils'

// Configuración global de Vue Test Utils
config.global.stubs = {}

// Mock de ResizeObserver para tests
global.ResizeObserver = class ResizeObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
}

// Mock de console para reducir ruido en tests
beforeEach(() => {
  console.error = vi.fn()
  console.warn = vi.fn()
})
```

## Ejemplos de Tests

### Test de Componente Vue
```javascript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import HelloWorld from '../HelloWorld.vue'

describe('HelloWorld', () => {
  it('renders properly', () => {
    const wrapper = mount(HelloWorld)
    expect(wrapper.exists()).toBe(true)
  })

  it('increments counter when button is clicked', async () => {
    const wrapper = mount(HelloWorld)
    const button = wrapper.find('button')
    
    expect(wrapper.text()).toContain('count is 0')
    await button.trigger('click')
    expect(wrapper.text()).toContain('count is 1')
  })
})
```

### Test de Props
```javascript
it('renders with custom message prop', () => {
  const customMessage = 'Hello Test World'
  const wrapper = mount(HelloWorld, {
    props: { msg: customMessage }
  })
  
  expect(wrapper.text()).toContain(customMessage)
})
```

### Test de Eventos
```javascript
it('emits click event', async () => {
  const wrapper = mount(HelloWorld)
  await wrapper.find('button').trigger('click')
  expect(wrapper.emitted('click')).toBeTruthy()
})
```

## Coverage

### Configuración de Coverage
- **Provider**: v8 (nativo de Node.js)
- **Reporters**: text, json, html
- **Thresholds**: 80% mínimo para branches, functions, lines y statements

### Generar Reporte
```bash
npm run test:coverage
```

El reporte HTML se genera en `coverage/index.html`

## Mejores Prácticas

### 1. Organización de Tests
- Coloca tests junto a los componentes que prueban
- Usa nombres descriptivos para los tests
- Agrupa tests relacionados con `describe`

### 2. Testing de Componentes
- Usa `mount()` para testing completo
- Usa `shallowMount()` para testing aislado
- Testea props, eventos y renderizado

### 3. Mocking
- Mock external dependencies
- Usa `vi.fn()` para funciones mock
- Usa `vi.spyOn()` para spying

### 4. Async Testing
- Usa `async/await` para operaciones asíncronas
- Usa `flushPromises()` cuando sea necesario
- Testea estados de loading y error

## Troubleshooting

### Problemas Comunes

1. **Error de ResizeObserver**
   - Ya está mockeado en `setup.js`

2. **Error de jsdom**
   - Verifica que jsdom esté instalado
   - Asegúrate de que `environment: 'jsdom'` esté configurado

3. **Tests lentos**
   - Usa `shallowMount()` cuando sea posible
   - Mock external dependencies
   - Usa `test.concurrent()` para tests paralelos

### Debugging
```bash
# Ejecutar tests con más información
npm run test:run -- --reporter=verbose

# Ejecutar un test específico
npm run test:run -- src/components/__tests__/HelloWorld.test.js
```

## Integración con CI/CD

### GitHub Actions (ejemplo)
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '22'
      - run: npm ci
      - run: npm run test:coverage
```

## Recursos Adicionales

- [Vitest Documentation](https://vitest.dev/)
- [Vue Test Utils](https://test-utils.vuejs.org/)
- [Vue 3 Testing Best Practices](https://vuejs.org/guide/scaling-up/testing.html)
