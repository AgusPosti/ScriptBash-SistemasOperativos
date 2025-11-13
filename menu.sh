#!/bin/bash

# === Colores usados ===
verde="\e[32m"
rojo="\e[31m"
azul="\e[34m"
amarillo="\e[33m"
cian="\e[36m"
reset="\e[0m"

# === Menú principal ===
while true; do
    clear
    echo -e "${cian}╔══════════════════════════════════════════════╗${reset}"
    echo -e "		${azul}MENÚ DE SCRIPTS${reset}     "
    echo -e "${cian}╚══════════════════════════════════════════════╝${reset}"
    echo ""
    echo -e "${verde}[1]${reset} Informar sobre rendimiento actual de pc"
    echo -e "${verde}[2]${reset} Hacer backup de una carpeta"
    echo -e "${verde}[3]${reset} Limpiar archivos temporales(caché)"
    echo -e "${rojo}[0]${reset} Salir"
    echo ""
    echo -e "${cian}------------------------------------------------${reset}"
    read -p "Elige una opción (0-3): " opcion
    echo -e ""

    case $opcion in
    1) bash rendimiento_actual.sh ;;
    2) bash backup.sh ;;
    3) bash limpiar_cache.sh ;;
    0)  
        echo -e "${rojo}Saliendo del programa...${reset}"
        sleep 1 
        exit 0
        ;;
    *) echo -e "${amarillo}Opción inválida, ingrese de nuevo.${reset}"; sleep 1.5 ;;
    esac
done


