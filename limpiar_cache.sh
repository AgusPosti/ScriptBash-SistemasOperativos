#!/bin/bash

# === Colores ===
verde="\e[32m"
rojo="\e[31m"
azul="\e[34m"
amarillo="\e[33m"
cian="\e[36m"
reset="\e[0m"

clear
echo -e "${cian}LIMPIEZA DE ARCHIVOS TEMPORALES${reset}"
sleep 1

# ===  Pide carpeta al usuario ===
echo -e "${azul}Ingrese la ruta de la carpeta donde realizar cambios:${reset}"
read -p "Carpeta: " carpeta
echo ""

# Verificar que exista
if [ ! -d "$carpeta" ]; then
    echo -e "${rojo}Error: la carpeta no existe.${reset}"
    read -p "Presione ENTER para salir..." _
    exit 1
fi

# ===  Busca archivos temporales ===
echo -e "${cian}Buscando archivos en ${carpeta}...${reset}"
sleep 1

archivos=$(find "$carpeta" -type f \( -name "*.tmp" -o -name "*.log" -o -name "*.cache" -o -name "*.dat" -o -name "*.txt" \))

if [ -z "$archivos" ]; then
    echo -e "${verde}No se encontraron archivos temporales.${reset}"
    echo -e "\nPresione ${verde}ENTER${reset} para volver al menú..."
    read
    exit 0
fi

# === Muestra si encuentra archivos ===
echo ""
echo -e "${azul}Archivos encontrados:${reset}"
echo "$archivos"
echo ""
echo -e -n "${amarillo}¿Querés eliminar estos archivos? (s/n):${reset}"
read confirmar 

# === Borrar si confirma ===
if [[ "$confirmar" == "s" || "$confirmar" == "S" ]]; then
    cantidad=$(echo "$archivos" | wc -l)
    echo ""
    echo -e "${rojo}Eliminando $cantidad archivos...${reset}"
    find "$carpeta" -type f \( -name "*.tmp" -o -name "*.log" -o -name "*.cache" -o -name "*.dat" -o -name "*.txt" \) -delete
    echo ""
    echo -e "${verde}Limpieza terminada. Se eliminaron $cantidad archivos.${reset}"
else
    echo ""
    echo -e "${verde}Limpieza cancelada por el usuario.${reset}"
fi

echo ""
echo -e "${azul}Proceso finalizado:${reset} $carpeta"
echo ""
echo -e "\nPresione ${verde}ENTER${reset} para volver al menú..."
read