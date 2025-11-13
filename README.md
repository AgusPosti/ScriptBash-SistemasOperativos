#  Proyecto scripts de Automatización en Bash

## Descripción breve del proyecto
Este proyecto final fue diseñado para cumplir con ciertas pautas pedidas por el docente para la materia de **sistemas operativos**.
Trata de una serie de **scripts** Bash que facilitan y automatizan una serie de comandos para lograr tareas básicas.
Contiene un **menú principal** con colores intuitivos, que estan pensados para facilitar el uso de cada script.

El menú contiene estos scripts:
1) **rendimiento_actual.sh**: Crea un archivo .txt que muestra el uso actual de la cpu, ram y disco, y a su vez crea una carpeta llamada "rendimiento" donde se van a alojar estos archivos .txt. Además identifica si esta carpeta ya está creada, si lo está, envía directamente los archivos a la carpeta llamada "rendimiento" creada previamente por el script.
2) **backup.sh**: Crea un breve respaldo de una carpeta y al hacerlo reiteradas veces, sobreescribe las copias nuevas por las antiguas.
3) **limpiar_cache.sh**: Elimina archivos de un directorio.

---

##  Instrucciones de uso y ejemplos

###  Requisitos
- Tener instalado **Bash** (Linux, macOS o WSL en Windows).  
- Dar permisos de ejecución a los scripts con:
  ```bash
  chmod +x *.sh
   Ejecución

Abrir una terminal en la carpeta del proyecto.

# Ejecutar el menú principal con:
  ```bash
./menu.sh
  ```
  Elegir una de las opciones que aparecen:

[1] Informar sobre rendimiento actual de pc 
[2] Hacer backup de una carpeta  
[3] Limbiar archivos temporales(caché)
[0] Salir  

## Ejemplo de uso

Si se elige la opción 1, el script crea automáticamente el archivo .txt que contiene el uso actual de la cpu, ram y disco a la carpeta "rendimiento" y puedes seguir interactuando con el menú.
