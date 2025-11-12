#!/bin/bash

# === 🎨 Colores ===
verde="\e[32m"
rojo="\e[31m"
azul="\e[34m"
amarillo="\e[33m"
cian="\e[36m"
reset="\e[0m"

# === 🧭 Menú principal l===
while true; do
    clear
    echo -e "${cian}╔══════════════════════════════════════════════╗${reset}"
    echo -e "		${azul}MENÚ DE SCRIPTS${reset}     "
    echo -e "${cian}╚══════════════════════════════════════════════╝${reset}"
    echo ""
    echo -e "${verde}[1]${reset} ejemplo 1"
    echo -e "${verde}[2]${reset} ejemplo 2"
    echo -e "${verde}[3]${reset} ejemplo 3"
    echo -e "${rojo}[0]${reset}  Salir"
    echo ""
    echo -e "${cian}------------------------------------------------${reset}"
    read -p "Elige una opción (0-3): " opcion
    echo -e ""

done


