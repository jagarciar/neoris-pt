#!/bin/bash
# Script de inicialización de SQL Server
# Este script espera a que SQL Server esté listo y ejecuta el script de inicialización

# Esperar 30 segundos para asegurar que SQL Server ha iniciado completamente
echo "Esperando a que SQL Server inicie completamente (30 segundos)..."
sleep 30

# Intentar ejecutar el script de inicialización
echo "Ejecutando script de inicialización de base de datos..."

# Ejecutar el script SQL
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -d master -i /docker-entrypoint-initdb.d/init.sql

# Verificar el resultado
if [ $? -eq 0 ]; then
    echo "✅ Base de datos inicializada correctamente"
else
    echo "❌ Error al inicializar la base de datos"
    exit 1
fi

echo "Script de inicialización completado"
