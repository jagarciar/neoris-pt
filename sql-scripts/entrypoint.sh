#!/bin/bash
# Script para inicializar la base de datos SQL Server
# Este script espera a que SQL Server esté listo y luego ejecuta el script de inicialización

# Esperar a que SQL Server esté listo
echo "Esperando a que SQL Server esté listo..."
sleep 30s

# Ejecutar el script de inicialización
echo "Ejecutando script de inicialización de base de datos..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i /docker-entrypoint-initdb.d/init.sql

if [ $? -eq 0 ]; then
    echo "Base de datos inicializada exitosamente"
else
    echo "Error al inicializar la base de datos"
    exit 1
fi
