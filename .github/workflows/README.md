# GitHub Actions Workflows

Este directorio contiene los workflows de GitHub Actions para automatizar el testing y deploy de la aplicación Vue.

## Workflows Disponibles

### 1. `test.yml` - Testing Automático
- **Trigger**: Push a `main`, `develop` o Pull Requests
- **Función**: Ejecuta tests de la aplicación antes del deploy
- **Incluye**:
  - Instalación de dependencias
  - Build del proyecto
  - Test del servidor de desarrollo
  - Test de construcción de Docker
  - Validación de docker-compose

### 2. `deploy.yml` - Deploy de Desarrollo
- **Trigger**: Push a `main` o manual
- **Función**: Deploy automático usando docker-compose
- **Puerto**: 5174 (mapeado desde 5173 del contenedor)
- **Características**:
  - Hot reload habilitado
  - Volúmenes persistentes para node_modules y cache
  - Health checks automáticos
  - Logs detallados

### 3. `deploy-production.yml` - Deploy de Producción
- **Trigger**: Push a `main` con tags `v*` o manual
- **Función**: Deploy optimizado para producción
- **Puerto**: 8080
- **Características**:
  - Build optimizado con Nginx
  - Imagen Docker multi-stage
  - Endpoints de health check y build info
  - Configuración de producción

## Cómo Usar

### Deploy Automático
```bash
# Para desarrollo (cada push a main)
git push origin main

# Para producción (con tag)
git tag v1.0.0
git push origin v1.0.0
```

### Deploy Manual
1. Ve a la pestaña "Actions" en GitHub
2. Selecciona el workflow deseado
3. Haz clic en "Run workflow"
4. Selecciona la rama y ejecuta

## Puertos y URLs

- **Desarrollo**: http://localhost:5174
- **Producción**: http://localhost:8080
- **Health Check**: http://localhost:8080/health
- **Build Info**: http://localhost:8080/build-info

## Monitoreo

Los workflows incluyen:
- ✅ Verificación de health checks
- 📊 Logs detallados del servicio
- 🔍 Validación de endpoints
- ⏱️ Timeouts configurables
- 🧹 Limpieza automática de recursos

## Troubleshooting

### Si el deploy falla:
1. Revisa los logs en GitHub Actions
2. Verifica que Docker esté corriendo en el runner
3. Comprueba que los puertos no estén ocupados
4. Revisa la conectividad de red

### Comandos útiles:
```bash
# Ver estado de contenedores
docker-compose -f docker-compose-localhost.yml ps

# Ver logs
docker-compose -f docker-compose-localhost.yml logs app

# Parar servicios
docker-compose -f docker-compose-localhost.yml down

# Limpiar Docker
docker system prune -f
```
