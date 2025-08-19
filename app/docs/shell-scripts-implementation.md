# Implementación de Organización de Scripts Shell

## Resumen

Se ha implementado un sistema completo de organización y estándares para scripts shell en el proyecto Vue 3 + Vite, asegurando que todos los archivos `.sh` se guarden exclusivamente en la carpeta `script/`.

## Regla Implementada

### Archivo: `.cursor/rules/shell-scripts.mdc`
- **Glob Pattern**: `*.sh`
- **Descripción**: Organización y estándares para scripts shell en proyectos Vue 3 + Vite
- **Aplicación**: Automática para todos los archivos `.sh`

## Estándares Definidos

### 1. Ubicación de Archivos
- ✅ **Todos los scripts `.sh` en `script/`**
- ✅ **Nunca en directorio raíz u otras ubicaciones**
- ✅ **Nombres descriptivos y consistentes**

### 2. Estructura de Scripts
- ✅ **Headers consistentes** con metadatos
- ✅ **Gestión de versiones Node.js** integrada
- ✅ **Manejo de errores** robusto
- ✅ **Logging estandarizado** con emojis

### 3. Categorías de Scripts
- **Desarrollo**: `dev.sh`, `dev-setup.sh`, `dev-reset.sh`
- **Testing**: `test.sh`, `test-coverage.sh`, `test-watch.sh`
- **Build**: `build.sh`, `build-dev.sh`, `build-analyze.sh`
- **Deployment**: `deploy.sh`, `deploy-staging.sh`, `deploy-production.sh`
- **Utilidades**: `utils.sh`, `cleanup.sh`, `backup.sh`

## Scripts Implementados

### 1. `script/dev.sh`
- **Propósito**: Iniciar entorno de desarrollo
- **Características**:
  - Verificación automática de versión Node.js
  - Instalación automática de dependencias
  - Logging consistente
  - Manejo de errores

### 2. `script/test.sh`
- **Propósito**: Ejecutar tests con múltiples modos
- **Modos disponibles**:
  - `run`: Tests normales
  - `watch`: Modo observación
  - `ui`: Interfaz gráfica
  - `coverage`: Con reporte de cobertura
- **Características**:
  - Gestión de versiones integrada
  - Logging estandarizado
  - Manejo de argumentos

### 3. `script/build.sh`
- **Propósito**: Build de producción optimizado
- **Características**:
  - Limpieza de builds anteriores
  - Ejecución de tests antes del build
  - Verificación de éxito del build
  - Reporte de tamaño del build

## Integración con Makefile

### Comandos Actualizados
```makefile
run:
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use
	./script/dev.sh

test:
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use
	./script/test.sh

test-watch:
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use
	./script/test.sh watch

test-ui:
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use
	./script/test.sh ui

test-coverage:
	export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use
	./script/test.sh coverage
```

## Estándares de Código

### Header Requerido
```bash
#!/bin/bash

# Script Name: [Descriptive Name]
# Purpose: [Brief description of what the script does]
# Author: [Your name or team]
# Date: [Creation date]
# Version: [Version number]

set -e  # Exit on any error
set -u  # Exit on undefined variables
```

### Gestión de Versiones Node.js
```bash
# Load nvm and use correct version
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use

# Verify correct version
EXPECTED_VERSION="v22.18.0"
CURRENT_VERSION=$(node --version)

if [ "$CURRENT_VERSION" != "$EXPECTED_VERSION" ]; then
    log_error "Wrong Node.js version detected"
    log_error "Expected: $EXPECTED_VERSION"
    log_error "Current:  $CURRENT_VERSION"
    exit 1
fi
```

### Funciones de Logging
```bash
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
```

### Manejo de Errores
```bash
# Error handler
error_handler() {
    log_error "Error occurred in script at line $1"
    exit 1
}

trap 'error_handler $LINENO' ERR
```

## Workflow de Desarrollo

### Comandos Disponibles
```bash
# Desarrollo
make run
./script/dev.sh

# Testing
make test
make test-watch
make test-ui
make test-coverage
./script/test.sh [run|watch|ui|coverage]

# Build
./script/build.sh
```

### Verificación de Funcionamiento
```bash
# Verificar que los scripts son ejecutables
chmod +x script/*.sh

# Probar script de testing
./script/test.sh run

# Probar script de desarrollo
./script/dev.sh
```

## Beneficios Implementados

### 1. Organización
- ✅ **Ubicación centralizada** en `script/`
- ✅ **Nomenclatura consistente**
- ✅ **Categorización clara**

### 2. Mantenibilidad
- ✅ **Headers informativos**
- ✅ **Logging estandarizado**
- ✅ **Manejo de errores robusto**

### 3. Consistencia
- ✅ **Gestión de versiones integrada**
- ✅ **Estándares de código**
- ✅ **Funciones reutilizables**

### 4. Automatización
- ✅ **Integración con Makefile**
- ✅ **Verificación automática**
- ✅ **Logging visual**

## Próximos Pasos

### Scripts Adicionales Recomendados
- **`script/deploy.sh`**: Script de deployment
- **`script/cleanup.sh`**: Limpieza de archivos temporales
- **`script/backup.sh`**: Backup de archivos importantes
- **`script/utils.sh`**: Funciones utilitarias comunes

### Mejoras Futuras
- **Validación de argumentos** más robusta
- **Configuración externa** para scripts
- **Logging a archivo** además de consola
- **Tests para scripts** shell

## Conclusión

La implementación de la regla `shell-scripts.mdc` ha establecido un sistema completo y robusto para la organización de scripts shell en el proyecto. Todos los archivos `.sh` ahora se guardan exclusivamente en la carpeta `script/` con estándares consistentes, gestión de versiones integrada y manejo de errores robusto.

---

*Documento de implementación de organización de scripts shell*
*Última actualización: $(date)*
*Estado: Completamente implementado y funcional*
