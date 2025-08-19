#!/bin/bash

# Script para detener el self-hosted runner
# Uso: ./stop-runner.sh

# Configuración
PID_FILE="/var/run/github-runner.pid"
LOG_FILE="/var/log/github-runner.log"

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

# Verificar si existe el PID file
if [ ! -f "$PID_FILE" ]; then
    log_warning "No se encontró PID file. Buscando procesos de runner..."
    
    # Buscar procesos de runner manualmente
    RUNNER_PIDS=$(ps aux | grep "run.sh" | grep -v grep | awk '{print $2}')
    
    if [ -z "$RUNNER_PIDS" ]; then
        log_message "No se encontraron procesos de runner ejecutándose"
        exit 0
    else
        log_warning "Encontrados procesos de runner: $RUNNER_PIDS"
        echo "¿Deseas detener todos estos procesos? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            for pid in $RUNNER_PIDS; do
                log_message "Deteniendo proceso $pid..."
                kill $pid
            done
            log_message "✅ Todos los procesos de runner detenidos"
        else
            log_message "Operación cancelada"
            exit 0
        fi
    fi
else
    # Leer PID del archivo
    RUNNER_PID=$(cat "$PID_FILE")
    
    # Verificar si el proceso existe
    if ! ps -p $RUNNER_PID > /dev/null 2>&1; then
        log_warning "Proceso $RUNNER_PID no está ejecutándose. Limpiando PID file..."
        rm -f "$PID_FILE"
        exit 0
    fi
    
    log_message "Deteniendo runner con PID: $RUNNER_PID"
    
    # Intentar detener de forma graceful primero
    kill $RUNNER_PID
    
    # Esperar un poco para que se detenga graceful
    sleep 3
    
    # Verificar si se detuvo
    if ps -p $RUNNER_PID > /dev/null 2>&1; then
        log_warning "El proceso no se detuvo graceful. Forzando detención..."
        kill -9 $RUNNER_PID
        sleep 1
        
        if ps -p $RUNNER_PID > /dev/null 2>&1; then
            log_error "❌ No se pudo detener el proceso $RUNNER_PID"
            exit 1
        fi
    fi
    
    # Limpiar PID file
    rm -f "$PID_FILE"
    log_message "✅ Runner detenido correctamente"
fi

# Mostrar logs recientes si existen
if [ -f "$LOG_FILE" ]; then
    echo ""
    log_message "Últimas líneas del log:"
    echo "----------------------------------------"
    tail -10 "$LOG_FILE"
    echo "----------------------------------------"
fi
