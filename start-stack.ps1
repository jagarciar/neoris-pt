# Script para iniciar SQL Server en Docker para el stack de Neoris PT
# Uso: .\start-stack.ps1

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Neoris PT - SQL Server en Docker        " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que Docker Desktop está corriendo
Write-Host "[1/4] Verificando Docker Desktop..." -ForegroundColor Yellow
$dockerRunning = Get-Process "Docker Desktop" -ErrorAction SilentlyContinue
if (-not $dockerRunning) {
    Write-Host "❌ Docker Desktop no está corriendo. Por favor, inícialo primero." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Docker Desktop está corriendo" -ForegroundColor Green
Write-Host ""

# Cambiar al directorio del proyecto
Write-Host "[2/4] Cambiando al directorio del proyecto..." -ForegroundColor Yellow
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath
Write-Host "✅ Ubicado en: $scriptPath" -ForegroundColor Green
Write-Host ""

# Verificar que docker-compose.yml existe
if (-not (Test-Path "docker-compose.yml")) {
    Write-Host "❌ No se encuentra docker-compose.yml en el directorio actual" -ForegroundColor Red
    exit 1
}

# Detener contenedores anteriores si existen
Write-Host "[3/4] Deteniendo contenedores anteriores..." -ForegroundColor Yellow
docker-compose down 2>$null
Write-Host "✅ Contenedores anteriores detenidos" -ForegroundColor Green
Write-Host ""

# Iniciar servicios
Write-Host "[4/4] Iniciando SQL Server..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al iniciar SQL Server" -ForegroundColor Red
    exit 1
}
Write-Host "✅ SQL Server iniciado" -ForegroundColor Green
Write-Host ""
Write-Host "[5/4] Esperando a que SQL Server esté listo..." -ForegroundColor Yellow

Write-Host "    Esperando SQL Server (puede tardar 30-60 segundos)..." -ForegroundColor Gray
$sqlReady = $false
$attempts = 0
$maxAttempts = 30

while (-not $sqlReady -and $attempts -lt $maxAttempts) {
    $attempts++
    $healthStatus = docker inspect neoris-sqlserver --format='{{.State.Health.Status}}' 2>$null
    
    if ($healthStatus -eq "healthy") {
        $sqlReady = $true
        Write-Host "    ✅ SQL Server está listo" -ForegroundColor Green
    } else {
        Write-Host "    ⏳ Intento $attempts/$maxAttempts - Estado: $healthStatus" -ForegroundColor Gray
        Start-Sleep -Seconds 2
    }
}

if (-not $sqlReady) {
    Write-Host "    ⚠️  SQL Server tardó más de lo esperado, pero continuando..." -ForegroundColor Yellow
}

Write-Host ""

# Verificar estado de los contenedores
Write-Host "Verificando estado de los contenedores..." -ForegroundColor Yellow
Write-Host ""
docker-compose ps
Write-Host ""

# Mostrar información de acceso
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          Base de Datos Disponible          " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "🗄️  SQL Server:          " -NoNewline
Write-Host "localhost,1433" -ForegroundColor Green
Write-Host "   └─ Usuario: sa" -ForegroundColor Gray
Write-Host "   └─ Password: Neoris2026!" -ForegroundColor Gray
Write-Host "   └─ Base de Datos: NeorisPTDB" -ForegroundColor Gray
Write-Host ""

# Mostrar instrucciones para el backend y frontend
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "    Próximos Pasos - Backend y Frontend     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚡ Para ejecutar el BACKEND:" -ForegroundColor Yellow
Write-Host "   1. Abre una nueva terminal" -ForegroundColor White
Write-Host "   2. Navega a: neoris-pt-backend" -ForegroundColor White
Write-Host "   3. Abre en Visual Studio: neoris-pt-backend.csproj" -ForegroundColor White
Write-Host "   4. Ejecuta el proyecto (F5 o Play Button)" -ForegroundColor White
Write-Host ""

Write-Host "⚡ Para ejecutar el FRONTEND:" -ForegroundColor Yellow
Write-Host "   1. Abre una nueva terminal" -ForegroundColor White
Write-Host "   2. Navega a: neoris-pt-frontend" -ForegroundColor White
Write-Host "   3. Abre en Visual Studio: neoris-pt-frontend.csproj" -ForegroundColor White
Write-Host "   4. Ejecuta el proyecto (F5 o Play Button)" -ForegroundColor White
Write-Host ""

# Comandos útiles
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "           Comandos Útiles                  " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ver logs de SQL Server:" -ForegroundColor Yellow
Write-Host "  docker-compose logs -f sqlserver" -ForegroundColor White
Write-Host ""
Write-Host "Conectarse a SQL Server desde línea de comandos:" -ForegroundColor Yellow
Write-Host "  docker exec -it neoris-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Neoris2026!" -ForegroundColor White
Write-Host ""
Write-Host "Detener SQL Server:" -ForegroundColor Yellow
Write-Host "  docker-compose down" -ForegroundColor White
Write-Host ""

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "    ✅ SQL Server iniciado correctamente!   " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
