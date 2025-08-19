#!/bin/bash

# Script para ejecutar el self-hosted runner en segundo plano
# Uso: ./run-runner.sh

# Configuración
RUNNER_DIR="/home/jorgeblanc9/actions-runner"  # Cambia esto por la ruta real de tu runner
LOG_FILE="/var/log/github-runner.log"
PID_FILE="/var/run/github-runner.pid"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
log_message() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_error() {
    echo -e "${RED}[$(date '+%Y-%m-%d %H:%M:%S')] ERROR:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')] WARNING:${NC} $1"
}

# Verificar si el runner ya está ejecutándose
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        log_warning "El runner ya está ejecutándose con PID $PID"
        echo "Para detenerlo: kill $PID"
        exit 1
    else
        log_warning "PID file encontrado pero proceso no está ejecutándose. Limpiando..."
        rm -f "$PID_FILE"
    fi
fi

# Verificar que el directorio del runner existe
if [ ! -d "$RUNNER_DIR" ]; then
    log_error "Directorio del runner no encontrado: $RUNNER_DIR"
    echo "Por favor, actualiza RUNNER_DIR en este script con la ruta correcta"
    exit 1
fi

# Cambiar al directorio del runner
cd "$RUNNER_DIR"

# Crear directorio de logs si no existe
mkdir -p "$(dirname "$LOG_FILE")"

log_message "Iniciando self-hosted runner en segundo plano..."

# Ejecutar el runner en segundo plano
nohup ./run.sh > "$LOG_FILE" 2>&1 &
RUNNER_PID=$!

# Guardar el PID
echo $RUNNER_PID > "$PID_FILE"

log_message "Runner iniciado con PID: $RUNNER_PID"
log_message "Logs disponibles en: $LOG_FILE"
log_message "PID guardado en: $PID_FILE"

# Verificar que el proceso se inició correctamente
sleep 2
if ps -p $RUNNER_PID > /dev/null 2>&1; then
    log_message "✅ Runner ejecutándose correctamente"
    echo ""
    echo "Comandos útiles:"
    echo "  Ver logs: tail -f $LOG_FILE"
    echo "  Detener runner: kill $RUNNER_PID"
    echo "  Verificar estado: ps aux | grep run.sh"
else
    log_error "❌ Error al iniciar el runner"
    rm -f "$PID_FILE"
    exit 1
fi
