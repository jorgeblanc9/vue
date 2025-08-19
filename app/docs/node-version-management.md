# Gestión de Versiones de Node.js

## 📋 Resumen

Este proyecto utiliza **Node.js 22.18.0** como versión específica, definida en el archivo `.nvmrc`. Se han implementado reglas y scripts para asegurar que siempre se use la versión correcta.

## 🎯 Versión Requerida

- **Node.js**: 22.18.0 (definida en `.nvmrc`)
- **npm**: Compatible con Node.js 22.18.0
- **nvm**: Requerido para gestión de versiones

## 🛠️ Implementación

### Reglas de Cursor
- **`.cursor/rules/node-version.mdc`**: Regla principal para gestión de versiones
- **Todas las reglas actualizadas**: Incluyen verificación de versión Node.js

### Scripts de Desarrollo
- **`dev.sh`**: Script de desarrollo con verificación de versión
- **`test.sh`**: Script de testing con verificación de versión
- **Makefile**: Todos los targets incluyen gestión de versiones

## 🚀 Uso

### Scripts Recomendados
```bash
# Desarrollo
./dev.sh

# Testing
./test.sh          # Tests básicos
./test.sh watch    # Tests en modo watch
./test.sh ui       # Interfaz gráfica
./test.sh coverage # Tests con coverage
```

### Comandos Manuales
```bash
# Cargar versión correcta
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use

# Verificar versión
node --version  # Debe mostrar: v22.18.0
```

## ⚙️ Configuración

### Archivo .nvmrc
```
22.18.0
```

### Verificación Automática
Los scripts verifican automáticamente la versión correcta:
```bash
EXPECTED_VERSION="v22.18.0"
CURRENT_VERSION=$(node --version)

if [ "$CURRENT_VERSION" != "$EXPECTED_VERSION" ]; then
    echo "❌ Error: Wrong Node.js version detected"
    exit 1
fi
```

## 🔧 Troubleshooting

### Problema: Versión Incorrecta
```bash
# Solución
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use
```

### Problema: nvm no encontrado
```bash
# Verificar instalación
ls -la ~/.nvm

# Cargar manualmente
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### Problema: Versión no instalada
```bash
# Instalar versión requerida
nvm install 22.18.0
nvm use 22.18.0
```

## 📚 Integración con Reglas

### Reglas Actualizadas
- **`vue-testing.mdc`**: Incluye verificación de versión
- **`vitest-config.mdc`**: Incluye verificación de versión
- **`vue-test-utils.mdc`**: Incluye verificación de versión
- **`documentation.mdc`**: Incluye verificación de versión

### Aplicación Automática
Las reglas se aplican automáticamente cuando:
- Se ejecutan comandos npm
- Se instalan dependencias
- Se ejecutan tests
- Se realiza desarrollo

## 🎯 Beneficios

### Consistencia
- **Misma versión**: Todos los desarrolladores usan la misma versión
- **Sin conflictos**: Evita problemas de compatibilidad
- **Reproducible**: Entorno consistente en todos los sistemas

### Automatización
- **Verificación automática**: Scripts verifican versión antes de ejecutar
- **Error prevention**: Falla rápido si versión incorrecta
- **Feedback claro**: Mensajes de error informativos

### Mantenimiento
- **Fácil actualización**: Cambiar versión en `.nvmrc`
- **Documentación**: Reglas claras para el equipo
- **Escalabilidad**: Fácil agregar nuevas verificaciones

## 🔄 Workflow de Desarrollo

### Nuevo Desarrollador
1. Clonar repositorio
2. Ejecutar `./dev.sh` (verifica versión automáticamente)
3. Comenzar desarrollo

### Desarrollo Diario
1. Ejecutar `./dev.sh` para desarrollo
2. Ejecutar `./test.sh` para testing
3. Usar Makefile para comandos adicionales

### CI/CD
```yaml
# GitHub Actions
- uses: actions/setup-node@v3
  with:
    node-version-file: '.nvmrc'
```

## 📊 Estado de Implementación

### ✅ Completado
- [x] Regla principal de gestión de versiones
- [x] Scripts de desarrollo y testing
- [x] Actualización de todas las reglas existentes
- [x] Documentación completa
- [x] Verificación automática

### 🚀 Listo Para
- Desarrollo consistente
- Onboarding de nuevos desarrolladores
- CI/CD integration
- Escalabilidad del proyecto

---

*Gestión de versiones implementada exitosamente*
*Última actualización: $(date)*
