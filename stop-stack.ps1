# Script para detener el stack completo de Neoris PT
# Uso: .\stop-stack.ps1

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Neoris PT - Detener Stack Completo      " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Cambiar al directorio del proyecto
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Preguntar si desea eliminar volúmenes
Write-Host "Opciones de detención:" -ForegroundColor Yellow
Write-Host "1. Detener servicios (mantener datos de SQL Server)" -ForegroundColor White
Write-Host "2. Detener servicios y eliminar volúmenes (¡PERDERÁS LOS DATOS!)" -ForegroundColor Red
Write-Host ""
$option = Read-Host "Selecciona una opción (1 o 2)"

Write-Host ""
if ($option -eq "2") {
    Write-Host "⚠️  ADVERTENCIA: Se eliminarán todos los datos de la base de datos" -ForegroundColor Red
    $confirm = Read-Host "¿Estás seguro? Escribe 'SI' para confirmar"
    
    if ($confirm -eq "SI") {
        Write-Host ""
        Write-Host "Deteniendo servicios y eliminando volúmenes..." -ForegroundColor Yellow
        docker-compose down -v
        Write-Host "✅ Servicios detenidos y volúmenes eliminados" -ForegroundColor Green
    } else {
        Write-Host "Operación cancelada. Deteniendo servicios sin eliminar volúmenes..." -ForegroundColor Yellow
        docker-compose down
        Write-Host "✅ Servicios detenidos (datos preservados)" -ForegroundColor Green
    }
} else {
    Write-Host "Deteniendo servicios..." -ForegroundColor Yellow
    docker-compose down
    Write-Host "✅ Servicios detenidos (datos preservados)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Estado actual de los contenedores:" -ForegroundColor Yellow
docker ps -a --filter "name=neoris"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "       Stack detenido correctamente         " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para volver a iniciar, ejecuta: .\start-stack.ps1" -ForegroundColor Gray
Write-Host ""
