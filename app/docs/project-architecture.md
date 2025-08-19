# Arquitectura del Proyecto Vue 3 + Vite

## Resumen Ejecutivo

Este es un proyecto Vue 3 con Vite en su estado inicial, configurado como una aplicación SPA (Single Page Application) con una estructura básica y escalable.

## Stack Tecnológico

### Core Technologies
- **Framework**: Vue 3.5.18 (Composition API)
- **Build Tool**: Vite 7.1.2
- **Plugin**: @vitejs/plugin-vue 6.0.1
- **Module System**: ES Modules (ESM)
- **Package Manager**: npm
- **Node.js**: 22.18.0 (via nvm)

### Testing Dependencies
- **Vitest**: 3.2.4 (Framework de testing)
- **@vitest/ui**: 3.2.4 (Interfaz gráfica)
- **@vitest/coverage-v8**: 3.2.4 (Coverage)
- **@vue/test-utils**: 2.4.6 (Testing de componentes)
- **jsdom**: 26.1.0 (Entorno DOM)

### Características Técnicas
- **Type**: `module` (ESM nativo)
- **Private**: true (no publicación en npm)
- **Version**: 0.0.0 (proyecto inicial)

## Estructura del Proyecto

### Estructura Actual
```
vue/
├── .cursor/
│   └── rules/
│       ├── vue-testing.mdc
│       ├── vitest-config.mdc
│       ├── vue-test-utils.mdc
│       ├── vitest.mdc
│       ├── vite-rules.mdc
│       ├── vue-rules.mdc
│       ├── documentation.mdc
│       ├── node-version.mdc
│       └── shell-scripts.mdc
├── docs/
│   ├── README.md
│   ├── project-architecture.md
│   ├── testing-strategy.md
│   ├── TESTING.md
│   ├── vitest-setup-summary.md
│   ├── node-version-management.md
│   └── documentation-reorganization-summary.md
├── script/
│   ├── dev.sh
│   ├── test.sh
│   └── build.sh
├── coverage/
│   ├── index.html
│   ├── coverage-final.json
│   └── [archivos de coverage]
├── src/
│   ├── __tests__/
│   │   ├── setup.js
│   │   └── App.test.js
│   ├── assets/
│   │   └── vue.svg
│   ├── components/
│   │   ├── __tests__/
│   │   │   └── HelloWorld.test.js
│   │   └── HelloWorld.vue
│   ├── App.vue
│   ├── main.js
│   └── style.css
├── public/
│   └── vite.svg
├── .git/
├── .vscode/
├── node_modules/
├── .gitignore
├── .nvmrc
├── index.html
├── Makefile
├── package.json
├── package-lock.json
├── README.md
└── vite.config.js
```

### Análisis de la Estructura

#### **Directorio `src/`**
- **`main.js`**: Punto de entrada de la aplicación
- **`App.vue`**: Componente raíz de la aplicación
- **`style.css`**: Estilos globales
- **`assets/`**: Recursos estáticos (imágenes, iconos)
- **`components/`**: Componentes Vue reutilizables

#### **Directorio `public/`**
- Archivos estáticos servidos directamente
- `vite.svg`: Icono de la aplicación

#### **Configuración**
- **`vite.config.js`**: Configuración de Vite
- **`package.json`**: Dependencias y scripts
- **`index.html`**: Template HTML principal

## Arquitectura de Componentes

### Patrón Actual
- **Composition API**: Uso de `<script setup>` y `ref()`
- **Single File Components (SFC)**: Archivos `.vue` con template, script y style
- **Componente Raíz**: `App.vue` como contenedor principal
- **Componente Hijo**: `HelloWorld.vue` como ejemplo de componente

### Ejemplo de Componente
```vue
<script setup>
import { ref } from 'vue'

defineProps({
  msg: String,
})

const count = ref(0)
</script>

<template>
  <h1>{{ msg }}</h1>
  <div class="card">
    <button type="button" @click="count++">count is {{ count }}</button>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
```

## Configuración de Desarrollo

### Gestión de Versiones
- **Node.js**: 22.18.0 (definida en `.nvmrc`)
- **nvm**: Gestión automática de versiones
- **Verificación**: Scripts verifican versión antes de ejecutar

### Scripts Disponibles
```json
{
  "scripts": {
    "dev": "vite --host 0.0.0.0 --port 5173",
    "build": "vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:run": "vitest run",
    "test:coverage": "vitest run --coverage",
    "test:watch": "vitest --watch"
  }
}
```

### Configuración Vite
```javascript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

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
        'coverage/',
        '*.config.js',
        '*.config.ts'
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

### Configuración de Desarrollo
- **Host**: 0.0.0.0 (accesible desde red local)
- **Puerto**: 5173
- **Hot Module Replacement (HMR)**: Habilitado
- **ES Modules**: Nativo
- **Node.js Version**: 22.18.0 (automática via nvm)
- **Testing**: Vitest con coverage automático

## Estado Actual del Proyecto

### Características Implementadas
- ✅ Configuración básica de Vue 3 + Vite
- ✅ Componente de ejemplo funcional
- ✅ Hot Module Replacement
- ✅ Estilos CSS básicos
- ✅ Estructura de carpetas organizada
- ✅ Testing completo con Vitest y Vue Test Utils
- ✅ Documentación organizada en `docs/`
- ✅ Gestión de versiones de Node.js con nvm
- ✅ Scripts de desarrollo y testing automatizados
- ✅ Coverage de tests configurado (88.88% statements)
- ✅ Reglas de Cursor para desarrollo consistente
- ✅ Makefile con gestión de versiones integrada

### Características Pendientes
- ❌ State Management (Pinia/Vuex)
- ❌ Routing (Vue Router)
- ❌ UI Framework (Vuetify/Element Plus)
- ❌ TypeScript
- ❌ ESLint/Prettier
- ❌ CI/CD Pipeline

## Testing y Herramientas

### Testing Framework
- **Vitest**: Framework principal de testing
- **Vue Test Utils**: Testing de componentes Vue
- **jsdom**: Entorno DOM para tests
- **Coverage**: v8 provider con thresholds del 80%

### Estructura de Tests
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

### Coverage Actual
- **Statements**: 88.88%
- **Branches**: 75%
- **Functions**: 50%
- **Lines**: 88.88%
- **Archivos cubiertos**: App.vue (100%), HelloWorld.vue (100%)

### Herramientas de Desarrollo
- **Makefile**: Comandos con gestión de versiones integrada
- **Scripts**: Organizados en `script/` con estándares definidos
- **Reglas de Cursor**: Automatización de desarrollo
- **Documentación**: Organizada en `docs/` con estándares definidos

### Organización de Scripts
- **Ubicación**: Todos los scripts `.sh` en carpeta `script/`
- **Estándares**: Headers consistentes, logging, manejo de errores
- **Gestión de versiones**: Verificación automática de Node.js
- **Categorías**: Desarrollo, testing, build, deployment, utilidades

### Reglas de Cursor Implementadas
- **`vue-testing.mdc`**: Estrategia general de testing
- **`vitest-config.mdc`**: Configuración específica de Vitest
- **`vue-test-utils.mdc`**: Mejores prácticas de Vue Test Utils
- **`node-version.mdc`**: Gestión de versiones de Node.js
- **`documentation.mdc`**: Estándares de documentación
- **`shell-scripts.mdc`**: Organización y estándares de scripts
- **`vitest.mdc`**: Reglas generales de Vitest
- **`vite-rules.mdc`**: Mejores prácticas de Vite
- **`vue-rules.mdc`**: Mejores prácticas de Vue 3

## Patrones Arquitectónicos

### 1. Composition API
- Uso de `<script setup>` para simplicidad
- `ref()` para reactividad
- `defineProps()` para props
- `defineEmits()` para eventos (cuando sea necesario)

### 2. Single File Components
- Template, script y styles en un archivo
- Scoped styles para encapsulación
- Import/export de componentes

### 3. Modular Structure
- Separación clara de responsabilidades
- Componentes en directorio dedicado
- Assets organizados por tipo

## Decisiones de Diseño

### 1. Framework Selection
- **Vue 3**: Por su reactividad y Composition API
- **Vite**: Por su velocidad y configuración simple
- **ESM**: Para compatibilidad moderna

### 2. Estructura de Carpetas
- **Feature-based**: Organización por características
- **Separation of Concerns**: Separación clara de responsabilidades
- **Scalability**: Estructura preparada para crecimiento

### 3. Configuración
- **Minimal**: Configuración mínima para empezar
- **Extensible**: Fácil de extender según necesidades
- **Standard**: Sigue estándares de la comunidad

## Roadmap de Desarrollo

### Fase 1: Fundamentos (Completada)
- ✅ Configuración básica
- ✅ Componente de ejemplo
- ✅ Estructura de carpetas

### Fase 2: Testing (Completada)
- ✅ Configurar Vitest
- ✅ Implementar tests de componentes
- ✅ Configurar coverage
- ✅ Documentación de testing
- ✅ Gestión de versiones de Node.js
- ✅ Scripts automatizados de desarrollo

### Fase 3: Funcionalidad
- 📋 State Management (Pinia)
- 📋 Routing (Vue Router)
- 📋 UI Components
- 📋 API Integration

### Fase 4: Optimización
- 📋 TypeScript
- 📋 Performance optimization
- 📋 Build optimization
- 📋 CI/CD Pipeline

## Workflow de Desarrollo

### Comandos Principales
```bash
# Desarrollo con gestión de versiones
make run

# Testing con gestión de versiones
make test
make test-watch
make test-ui
make test-coverage

# Scripts directos desde carpeta script/
./script/dev.sh
./script/test.sh [run|watch|ui|coverage]

# Verificación de versión Node.js
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use
```

### Proceso de Desarrollo
1. **Setup**: Cargar versión correcta de Node.js
2. **Desarrollo**: Usar `make run` para desarrollo
3. **Testing**: Ejecutar tests con `make test`
4. **Coverage**: Verificar coverage con `make test-coverage`
5. **Documentación**: Mantener documentación actualizada

## Convenciones de Código

### Naming Conventions
- **Componentes**: PascalCase (`HelloWorld.vue`)
- **Archivos**: kebab-case para assets
- **Variables**: camelCase
- **Constantes**: UPPER_SNAKE_CASE

### Estructura de Componentes
1. **Template** (HTML)
2. **Script** (JavaScript/TypeScript)
3. **Style** (CSS/SCSS)

### Imports
- **Relativos**: Para componentes locales
- **Absolutos**: Para utilidades globales (cuando se configure)

## Consideraciones de Performance

### Actual
- **Bundle Size**: Mínimo (solo Vue core)
- **Loading**: Fast (Vite dev server)
- **HMR**: Instantáneo

### Futuro
- **Code Splitting**: Por rutas y componentes
- **Lazy Loading**: Para componentes pesados
- **Tree Shaking**: Eliminación de código no usado

## Seguridad

### Actual
- **XSS Protection**: Vue 3 sanitización automática
- **CSP**: Configuración básica

### Futuro
- **Input Validation**: Validación de formularios
- **Authentication**: Sistema de autenticación
- **Authorization**: Control de acceso

## Escalabilidad

### Preparado Para
- **Componentes**: Estructura modular con testing
- **Testing**: Framework completo con coverage
- **State Management**: Arquitectura preparada
- **Routing**: Estructura de carpetas compatible
- **Gestión de Versiones**: Sistema automatizado
- **Documentación**: Estándares y organización definidos
- **Automatización**: Reglas de Cursor implementadas

### Consideraciones
- **Modularity**: Componentes independientes con tests
- **Reusability**: Componentes reutilizables y testables
- **Maintainability**: Código limpio, documentado y con coverage
- **Performance**: Optimización continua con métricas
- **Consistency**: Gestión de versiones automatizada
- **Quality**: Testing automatizado con thresholds

---

*Documento de arquitectura del proyecto Vue 3 + Vite*
*Última actualización: $(date)*
*Estado: Completamente actualizado con todas las mejoras implementadas*
