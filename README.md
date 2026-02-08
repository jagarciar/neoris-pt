# Neoris - Solución Completa ASP.NET

Solución multi-proyecto con backend (Web API) y frontend (MVC) para gestionar Autores y Libros. Incluye soporte Docker y SQL Server.

## 🏛️ Arquitectura General

```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENTE (NAVEGADOR)                      │
└────────────────────────────┬────────────────────────────────┘
                             │
                             │ HTTP/HTTPS
                             │
┌────────────────────────────▼────────────────────────────────┐
│          FRONTEND (ASP.NET MVC - Puerto 4200)              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ • Views Razor (.cshtml)                              │  │
│  │ • Controllers MVC                                     │  │
│  │ • HttpClient + JWT Authentication                    │  │
│  │ • Unity Dependency Injection                          │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────┬────────────────────────────────┘
                             │
                             │ REST API Calls
                             │ (JWT Bearer Token)
                             │
┌────────────────────────────▼────────────────────────────────┐
│       BACKEND (ASP.NET Web API - Puerto 5000)              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ • RESTful Endpoints (/api/v1/...)                    │  │
│  │ • JWT Authentication & Authorization                    │  
│  │ • Entity Framework 6 (ORM)                              │  │                                                            │
│  │ • Swagger/Swashbuckle Documentation                  │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────┬───────────────────────────────|
                             │
                             │ SQL Queries
                             │
┌────────────────────────────▼────────────────────────────────┐
│    SQL SERVER (Contenedor Docker - Puerto 1433)           │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ • Database: NeorisPT                                 │  │
│  │ • Tablas: Autores, Libros                            │  │
│  │ • User: sa / Password: Neoris2026!                   │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Inicio Rápido

### Opción 1: Docker (Recomendado)

```powershell
.\start-stack.ps1
```

**Acceso:**
- Frontend: http://localhost:4200
- Backend API: http://localhost:5000
- Swagger: http://localhost:5000/swagger

### Opción 2: Visual Studio (Desarrollo Local)

1. Abre `Neoris.sln` en Visual Studio 2019/2022
2. Configura múltiples proyectos de inicio (clic derecho en solución → Properties → Startup Project)
3. Presiona **F5**

## 📚 Documentación

| Componente | Ubicación | Contenido |
|-----------|-----------|----------|
| **Backend** | [neoris-pt-backend/README.md](neoris-pt-backend/README.md) | Endpoints, Autenticación JWT, Entity Framework, Código fuente |
| **Frontend** | [neoris-pt-frontend/README.md](neoris-pt-frontend/README.md) | Arquitectura MVC, Consumo de API, Inyección de dependencias, Vistas Razor |
| **Docker Compose** | [docker-compose.yml](docker-compose.yml) | Configuración de servicios (Backend + Frontend + SQL Server) |
| **Base de Datos** | [sql-scripts/](sql-scripts/) | Scripts SQL de inicialización |


## 🛠️ Requisitos

### Desarrollo Local
- Visual Studio 2019/2022
- .NET Framework 4.8 Developer Pack
- Workload: "ASP.NET and web development"

### Docker
- Docker Desktop
- 8GB RAM mínimo

## 🔄 Git Workflow

```
Repositorio Raíz (Neoris/)
├── .git (Raíz principal)
├── .gitignore (ignora backend/ y frontend/)
│
├── neoris-pt-backend/
│   └── .git (Repo independiente)
│
└── neoris-pt-frontend/
    └── .git (Repo independiente)
```

Cada componente tiene su propio repositorio git independiente.


## 📝 Technology Stack

```
Backend:  ASP.NET Web API 5.2.9 + Entity Framework 6.4.4 + OWIN
Frontend: ASP.NET MVC 5.2.9 + Razor + HttpClient
Database: SQL Server 2022
DevOps:   Docker Compose
```


## 🏗️ Compilar desde Línea de Comandos

### Developer Command Prompt para Visual Studio:

```cmd
# Restaurar paquetes NuGet
nuget restore Neoris.sln

# Compilar toda la solución
msbuild Neoris.sln /p:Configuration=Release

# Compilar solo el backend
msbuild neoris-pt-backend\neoris-pt-backend.csproj /p:Configuration=Release
```

## 🧪 Ejecutar Proyectos Múltiples

Para ejecutar backend y frontend simultáneamente:

```
1. Clic derecho en la solución "Neoris"
2. Properties → Common Properties → Startup Project
3. Selecciona "Multiple startup projects"
4. Configura Action = "Start" para ambos proyectos
5. Presiona F5
```