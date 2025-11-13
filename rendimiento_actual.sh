#!/bin/bash

# --- Configuración de Directorio y Archivo ---
# 1. Nombre de la carpeta de destino
TARGET_DIR="Rendimiento" 
# 2. Nombre del archivo de log, incluyendo la carpeta
LOG_FILE="$TARGET_DIR/system_usage_$(date +%Y%m%d_%H%M%S).log"
DATE_FORMAT="%Y-%m-%d %H:%M:%S"

# 3. Crear la carpeta si no existe
mkdir -p "$TARGET_DIR"

# --- Encabezado del informe ---
# Usamos "$LOG_FILE" para todas las salidas
echo "=================================================" > "$LOG_FILE"
echo "         INFORME DE USO DEL SISTEMA " >> "$LOG_FILE"
echo "=================================================" >> "$LOG_FILE"
echo "Fecha y Hora del Informe: $(date +"$DATE_FORMAT")" >> "$LOG_FILE"

echo "-------------------------------------------------" >> "$LOG_FILE"

# --- 1. Uso de la CPU (Carga Total del Sistema desde /proc/stat) ---
echo "### USO DE LA CPU (Carga Total del Sistema) ###" >> "$LOG_FILE"

if [ -f "/proc/stat" ]; then
    # 1. Primera lectura de /proc/stat
    read -r _ user nice system idle iowait irq softirq steal guest < /proc/stat
    
    # Calcula el tiempo total y el tiempo inactivo (idle)
    TOTAL_TIME_1=$((user + nice + system + idle + iowait + irq + softirq + steal + guest))
    IDLE_TIME_1=$idle
    
    # Espera un breve momento para obtener una muestra significativa
    sleep 1 
    
    # 2. Segunda lectura de /proc/stat
    read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 < /proc/stat
    
    # Calcula el tiempo total y el tiempo inactivo (idle)
    TOTAL_TIME_2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2 + guest2))
    IDLE_TIME_2=$idle2
    
    # Calcula las diferencias de tiempo
    TOTAL_DIFF=$((TOTAL_TIME_2 - TOTAL_TIME_1))
    IDLE_DIFF=$((IDLE_TIME_2 - IDLE_TIME_1))

    # Cálculo del uso de CPU: 100 * (1 - (IDLE_DIFF / TOTAL_DIFF))
    # Usamos 'awk' para la división de punto flotante y evitar errores de división por cero
    if [ "$TOTAL_DIFF" -gt 0 ]; then
        # Nota: La primera "_" en 'read -r' descarta la palabra "cpu"
        CPU_USAGE=$(awk "BEGIN {printf \"%.2f\", 100 * (1 - ($IDLE_DIFF / $TOTAL_DIFF))}")
        echo "Uso actual de la CPU: **$CPU_USAGE%**" >> "$LOG_FILE"
    else
        echo "ADVERTENCIA: No se pudo calcular el uso de CPU. Diferencia de tiempo total cero." >> "$LOG_FILE"
    fi
else
    echo "ERROR: El archivo de estadísticas de CPU '/proc/stat' no fue encontrado." >> "$LOG_FILE"
fi
echo "-------------------------------------------------" >> "$LOG_FILE"

# --- 2. Uso de la Memoria (RAM) ---
echo "### USO DE LA MEMORIA (RAM) ###" >> "$LOG_FILE"
# No hay 'free' en Git Bash. Uso 'cat /proc/meminfo'
# Si /proc/meminfo no existe (lo cual es común en Git Bash simple), mostramos un mensaje alternativo.
if [ -f "/proc/meminfo" ]; then
    echo "--- Detalle de /proc/meminfo  ---" >> "$LOG_FILE"
    cat /proc/meminfo | grep -E 'MemTotal|MemFree|Cached|SwapTotal|SwapFree' >> "$LOG_FILE"
elif command -v systeminfo >/dev/null 2>&1; then
    echo "--- Resumen de Memoria (Usando comando nativo de Windows: systeminfo) ---" >> "$LOG_FILE"
    # Usamos 'systeminfo' nativo de Windows y filtramos la información de memoria
    systeminfo | grep -E 'Total Physical Memory|Available Physical Memory' >> "$LOG_FILE"
else
    echo "ADVERTENCIA: No se pudo obtener el uso de RAM. El comando 'free' no existe, y 'systeminfo' no es accesible." >> "$LOG_FILE"
fi
echo "-------------------------------------------------" >> "$LOG_FILE"


# --- 3. Uso del Disco ---
echo "### USO DEL DISCO (Sistema de Archivos) ###" >> "$LOG_FILE"
if command -v df >/dev/null 2>&1; then
    df -h -x tmpfs -x devtmpfs | grep -E '^Filesystem|/mnt/|C:|/d|/e|/' >> "$LOG_FILE"
else
    echo "ERROR: El comando 'df' no está disponible o no se pudo ejecutar." >> "$LOG_FILE"
fi
echo "-------------------------------------------------" >> "$LOG_FILE"

echo "Informe generado con éxito en: $LOG_FILE"