# 🚀 GitHub Actions - Auto Deploy Vue

## 📋 Resumen

Este proyecto Vue está configurado con **GitHub Actions** para **auto-desplegar automáticamente** cuando hagas push a la rama `main`. El sistema utiliza un **self-hosted runner** en tu servidor para compilar y desplegar la aplicación.

## 🎯 Flujo de Trabajo

```
Push a main → GitHub Actions → Self-Hosted Runner → Build Vue → Deploy Docker → Nginx
```

## 📁 Estructura de Archivos

```
vue/
├── app/                           # Código fuente de Vue
│   ├── .github/workflows/         # Workflows de GitHub Actions
│   │   ├── deploy.yml            # Auto-deploy en push a main
│   │   └── rollback.yml          # Rollback manual desde backup
│   ├── src/                      # Código fuente
│   ├── package.json              # Dependencias
│   └── vite.config.js            # Configuración de Vite
├── docker-compose-localhost.yml   # Desarrollo local
├── Dockerfile-vite               # Build de producción
├── nginx-vite.conf               # Configuración Nginx
├── setup-github-actions.sh       # Script de configuración
└── README-GITHUB-ACTIONS.md      # Esta documentación
```

## 🛠️ Configuración Inicial

### 1. Ejecutar Script de Configuración

```bash
# Desde el directorio del proyecto Vue
cd /home/jorgeblanc9/microservicios/portafolio/vue

# Ejecutar script de configuración
./setup-github-actions.sh
```

### 2. Verificar Self-Hosted Runner

```bash
# Verificar que el runner está ejecutándose
sudo systemctl status actions.runner.jorgeblanc9-vue.vmi2720891.service

# Si no está ejecutándose, iniciarlo
sudo systemctl start actions.runner.jorgeblanc9-vue.vmi2720891.service
sudo systemctl enable actions.runner.jorgeblanc9-vue.vmi2720891.service
```

### 3. Commit y Push de Workflows

```bash
# Ir al directorio de la app
cd app/

# Añadir workflows
git add .github/

# Commit
git commit -m "Add GitHub Actions workflows for auto-deploy"

# Push a main
git push origin main
```

## 🔄 Workflows Disponibles

### Auto Deploy (`deploy.yml`)

**Trigger**: Push a `main` o Pull Request a `main`

**Pasos**:
1. ✅ **Checkout** - Descarga el código
2. 💾 **Backup** - Crea backup del estado actual
3. 🛑 **Stop Services** - Detiene servicios actuales
4. 📥 **Update Code** - Actualiza código desde Git
5. 🔨 **Build** - Construye imagen Docker
6. 🚀 **Deploy** - Inicia servicios de producción
7. 🔍 **Verify** - Verifica que todo funciona
8. 🧹 **Cleanup** - Limpia recursos antiguos

### Rollback (`rollback.yml`)

**Trigger**: Manual (workflow_dispatch)

**Pasos**:
1. 🔍 **Verify Backup** - Verifica que existe el backup
2. 🛑 **Stop Services** - Detiene servicios actuales
3. 📦 **Restore** - Restaura desde backup
4. 🔨 **Rebuild** - Reconstruye imagen
5. 🚀 **Deploy** - Inicia servicios
6. 🔍 **Verify** - Verifica funcionamiento

## 🌐 URLs de Acceso

- **Aplicación**: `vue.webnovawp.com`
- **Health Check**: `vue.webnovawp.com/health`
- **Build Info**: `vue.webnovawp.com/build-info`

## 🔧 Comandos Útiles

### Verificar Estado

```bash
# Estado de contenedores
docker ps | grep vue-app

# Logs de la aplicación
docker compose -f docker-compose-production.yml logs -f

# Estado del runner
sudo systemctl status actions.runner.jorgeblanc9-vue.vmi2720891.service

# Logs del runner
sudo journalctl -u actions.runner.jorgeblanc9-vue.vmi2720891.service -f
```

### Gestión Manual

```bash
# Detener servicios
docker compose -f docker-compose-production.yml down

# Iniciar servicios
docker compose -f docker-compose-production.yml up -d

# Reconstruir imagen
docker build -f Dockerfile-vite -t vue-app:latest .

# Ver backups disponibles
ls -la backups/
```

### Troubleshooting

```bash
# Ver logs de GitHub Actions
tail -f /home/jorgeblanc9/actions-runner/_diag/*.log

# Verificar red Docker
docker network ls | grep microservices-network

# Verificar puertos
docker port vue-app-production

# Limpiar recursos Docker
docker system prune -f
```

## 📊 Monitoreo

### Health Checks

La aplicación incluye endpoints de monitoreo:

```bash
# Health check básico
curl -f http://vue.webnovawp.com/health

# Información del build
curl -f http://vue.webnovawp.com/build-info

# Página principal
curl -f http://vue.webnovawp.com/
```

### Logs

```bash
# Logs de la aplicación
docker compose -f docker-compose-production.yml logs --tail=50

# Logs del runner
sudo journalctl -u actions.runner.jorgeblanc9-vue.vmi2720891.service --no-pager -n 20

# Logs de Docker
docker logs vue-app-production --tail=50
```

## 🚨 Troubleshooting

### Problema: Workflow No Se Ejecuta

```bash
# 1. Verificar que el runner está online
# Ve a GitHub → Settings → Actions → Runners

# 2. Verificar logs del runner
sudo journalctl -u actions.runner.jorgeblanc9-vue.vmi2720891.service -f

# 3. Reiniciar runner
sudo systemctl restart actions.runner.jorgeblanc9-vue.vmi2720891.service
```

### Problema: Build Falla

```bash
# 1. Verificar dependencias
cd app/
npm install

# 2. Verificar build local
npm run build

# 3. Verificar Dockerfile
docker build -f ../Dockerfile-vite -t vue-app:test .
```

### Problema: Aplicación No Responde

```bash
# 1. Verificar contenedores
docker ps | grep vue-app

# 2. Verificar logs
docker compose -f docker-compose-production.yml logs

# 3. Verificar puertos
docker port vue-app-production

# 4. Verificar red
docker network inspect microservices-network
```

### Problema: Rollback No Funciona

```bash
# 1. Verificar backups disponibles
ls -la backups/

# 2. Verificar contenido del backup
tar -tzf backups/vue-backup-YYYYMMDD_HHMMSS.tar.gz | head -10

# 3. Restaurar manualmente
cd /home/jorgeblanc9/microservicios/portafolio/vue
tar -xzf backups/vue-backup-YYYYMMDD_HHMMSS.tar.gz
```

## 🔒 Seguridad

### Buenas Prácticas

1. **Backups automáticos**: Se crean antes de cada deploy
2. **Health checks**: Verificación automática de funcionamiento
3. **Rollback**: Capacidad de restaurar versiones anteriores
4. **Logs**: Registro completo de todas las operaciones
5. **Isolación**: Contenedores Docker aislados

### Variables de Entorno

```bash
# Producción
NODE_ENV=production
VITE_APP_TITLE=Vue App Production
VITE_APP_API_URL=https://api.webnovawp.com
```

## 📚 Documentación Relacionada

- [Guía de Despliegue GitHub Actions](../docs/deployment/GUIA-DESPLEGUE-GITHUB-ACTIONS-PRODUCCION.md)
- [Sistema Wake-on-Demand](../docs/wake-up-system/README.md)
- [Troubleshooting](../docs/soluciones-problemas/)

## 🆘 Soporte

Si encuentras problemas:

1. **Verificar logs**: Usa los comandos de troubleshooting
2. **Consultar documentación**: Revisa la documentación relacionada
3. **Rollback**: Usa el workflow de rollback si es necesario
4. **Contactar soporte**: Usa los canales de soporte del proyecto

---

**🎉 ¡Tu proyecto Vue está listo para auto-deploy!**

Cada vez que hagas push a main, la aplicación se desplegará automáticamente en producción.
