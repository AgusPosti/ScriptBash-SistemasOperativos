#!/bin/bash

# === Colores ===
verde="\e[32m"
rojo="\e[31m"
azul="\e[34m"
amarillo="\e[33m"
cian="\e[36m"
reset="\e[0m"

clear
echo -e "${cian}Iniciando proceso de respaldo...${reset}"
sleep 1.5

# === Carpeta de destino fija ===
destino="/c/backups"
mkdir -p "$destino"

# === Pide la carpeta de origen al usuario===
echo -e "${azul}Ingrese la ruta de la carpeta que quiere respaldar:${reset}"
read -e origen

# Verifica que exista
if [ ! -d "$origen" ]; then
    echo -e "\n${rojo}La carpeta ingresada no existe.${reset}"
    sleep 1
    exit 1
fi

# === Crea nombre con fecha ===
fecha=$(date +%Y-%m-%d_%H-%M)
archivo="$destino/respaldo_$fecha.tar.gz"

# === Crea el respaldo ===
echo -e "\n${amarillo}Creando backup...${reset}"
sleep 1
tar -czf "$archivo" "$origen" &> /dev/null

# === Verifica que se haya creado ===
if [ -f "$archivo" ]; then
    echo -e "\n${verde}Backup creado exitosamente.${reset}"
    echo -e "Guardado en: ${azul}$archivo${reset}"
else
    echo -e "\n${rojo}Error: no se pudo crear el backup.${reset}"
    exit 1
fi

# === Elimina los backups antiguos y dejar solo el nuevo ===
cd "$destino" || exit
for viejo in respaldo_*.tar.gz; do
    if [ "$viejo" != "$(basename "$archivo")" ]; then
        rm -f "$viejo"
        echo -e "Backup eliminado: ${rojo}$viejo${reset}"
    fi
done

# === Muestra mensaje final ===
echo -e "\n${verde}Proceso completado correctamente.${reset}"
echo -e "${amarillo}Solo se conserva el backup más reciente.${reset}"
echo -e "${azul}Ruta final del backup:${reset} $archivo"
echo -e "\nPresione ${verde}ENTER${reset} para volver al menú..."
read