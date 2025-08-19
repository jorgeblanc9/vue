# Vue 3 + Vite Project

Este es un proyecto Vue 3 con Vite configurado con testing completo usando Vitest.

## 🚀 Inicio Rápido

### Usando Scripts (Recomendado)
```bash
# Desarrollo con verificación de versión Node.js
./dev.sh

# Testing con verificación de versión Node.js
./test.sh          # Tests básicos
./test.sh watch    # Tests en modo watch
./test.sh ui       # Interfaz gráfica de tests
./test.sh coverage # Tests con coverage
```

### Usando Comandos Directos
```bash
# Asegurar versión correcta de Node.js
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use

# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev

# Ejecutar tests
npm run test:run

# Generar build de producción
npm run build
```

## 📚 Documentación

Toda la documentación del proyecto se encuentra en la carpeta [`docs/`](docs/):

- **[Documentación Principal](docs/README.md)** - Índice completo de documentación
- **[Arquitectura del Proyecto](docs/project-architecture.md)** - Estructura técnica y stack
- **[Guía de Testing](docs/TESTING.md)** - Implementación de tests con Vitest
- **[Estrategia de Testing](docs/testing-strategy.md)** - Enfoque y mejores prácticas

## 🧪 Testing

El proyecto incluye configuración completa de testing con Vitest:

```bash
# Ejecutar tests
npm run test:run

# Tests con coverage
npm run test:coverage

# Interfaz gráfica de tests
npm run test:ui

# Tests en modo watch
npm run test:watch
```

## 🛠️ Configuración Recomendada

### IDE Setup
- [VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar)
- Deshabilitar Vetur
- [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin)

### Configuración de Vite
Ver [Vite Configuration Reference](https://vitejs.dev/config/).

## 📋 Estado del Proyecto

### ✅ Completado
- Configuración básica Vue 3 + Vite
- Testing con Vitest y Vue Test Utils
- Documentación organizada
- Estructura de carpetas escalable

### 🚧 En Desarrollo
- State Management (Pinia)
- Routing (Vue Router)
- UI Framework
- TypeScript migration

## 🤝 Contribuir

1. Lee la [documentación](docs/README.md)
2. Sigue los estándares de testing
3. Mantén la documentación actualizada

---

*Proyecto Vue 3 + Vite con testing completo*
