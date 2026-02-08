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
│  │ • JWT Authentication & Authorization                  │  │
│  │ • Entity Framework 6 (ORM)                            │  │
│  │ • OWIN Pipeline                                       │  │
│  │ • Swagger/Swashbuckle Documentation                  │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────┬────────────────────────────────┘
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

## 📁 Estructura de la Solución

```
Neoris/
├── Neoris.sln                           # ← ABRE ESTE ARCHIVO
├── docker-compose.yml                   # Configuración Docker
├── start-stack.ps1 / stop-stack.ps1     # Scripts Docker
│
├── neoris-pt-backend/
│   ├── Controllers/, Models/, Services/ # Implementación backend
│   ├── Dockerfile                       # Imagen Docker
│   └── README.md                        # 📖 Documentación Backend
│
└── neoris-pt-frontend/
    ├── Controllers/, Views/, Models/    # Implementación frontend
    ├── Dockerfile                       # Imagen Docker
    └── README.md                        # 📖 Documentación Frontend
```

## 📚 Documentación

| Componente | Ubicación | Contenido |
|-----------|-----------|----------|
| **Backend** | [neoris-pt-backend/README.md](neoris-pt-backend/README.md) | Endpoints, Autenticación JWT, Entity Framework, Código fuente |
| **Frontend** | [neoris-pt-frontend/README.md](neoris-pt-frontend/README.md) | Arquitectura MVC, Consumo de API, Inyección de dependencias, Vistas Razor |
| **Docker Compose** | [docker-compose.yml](docker-compose.yml) | Configuración de servicios (Backend + Frontend + SQL Server) |
| **Base de Datos** | [sql-scripts/](sql-scripts/) | Scripts SQL de inicialización |

## 🔐 Credenciales de Prueba

```
Usuario: neoris-pt-frontend
Contraseña: SecurePassword2026#NeorisSecure
```

SQL Server:
```
Usuario: sa
Contraseña: Neoris2026!
```

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

## 📊 Estado de Componentes

| Componente | Status | Puerto | Docs |
|-----------|--------|--------|------|
| Backend | ✅ Funcional | 5000 | [README](neoris-pt-backend/README.md) |
| Frontend | ✅ Funcional | 4200 | [README](neoris-pt-frontend/README.md) |
| Database | ✅ Dockerizado | 1433 | [SQL-README](SQL-SERVER-README.md) |
| Docker | ✅ Listo | - | [DOCKER-README](DOCKER-README.md) |

## 📝 Technology Stack

```
Backend:  ASP.NET Web API 5.2.9 + Entity Framework 6.4.4 + OWIN
Frontend: ASP.NET MVC 5.2.9 + Razor + HttpClient
Database: SQL Server 2022
DevOps:   Docker Compose
```

---

**Última actualización:** Febrero 2026  
**Versión:** 1.0 - Producción Lista ✅


## 📁 Estructura de la Solución

```
Neoris/
├── Neoris.sln                    # Solución principal (ABRIR ESTE ARCHIVO)
├── docker-compose.yml            # ⚡ Configuración Docker
├── start-stack.ps1               # ⚡ Script para iniciar Docker
├── stop-stack.ps1                # ⚡ Script para detener Docker
├── README.md                     # Este archivo
├── DOCKER-README.md              # ⚡ Guía de Docker
├── SQL-SERVER-README.md          # ⚡ Guía de SQL Server
├── MIGRACION-SQL-SERVER.md       # ⚡ Guía de migración a BD
│
├── sql-scripts/                  # ⚡ Scripts de base de datos
│   ├── init.sql                  # Script de inicialización
│   └── init-db.sh                # Script de setup
│
├── neoris-pt-backend/            # Proyecto de Backend
│   ├── Controllers/              # Controladores de la API
│   │   ├── AuthController.cs                # Login JWT
│   │   ├── AutoresController.cs             # Controlador de autores
│   │   └── LibrosController.cs              # Controlador de libros
│   ├── Models/                   # Modelos de datos
│   │   ├── Autor.cs                          # Modelo de autor
│   │   └── Libro.cs                          # Modelo de libro
│   ├── Data/                     # Contexto de datos
│   │   └── NeorisPTDbContext.cs  # DbContext de Entity Framework
│   ├── Startup.cs                # Pipeline OWIN (JWT)
│   ├── App_Start/                # Configuración de la aplicación
│   ├── Dockerfile                # ⚡ Imagen Docker del backend
│   ├── .dockerignore             # ⚡ Exclusiones Docker
│   ├── Web.config                # Configuración principal
│   ├── Global.asax               # Punto de entrada
│   ├── neoris-pt-backend.csproj  # Archivo del proyecto
│   ├── packages.config           # Paquetes NuGet
│   └── README.md                 # Documentación del backend
│
└── neoris-pt-frontend/           # Proyecto de Frontend
    ├── Controllers/              # Controladores MVC
    ├── Models/                   # Modelos de datos
    ├── Views/                    # Vistas Razor
    ├── Content/                  # CSS y recursos
    ├── Scripts/                  # JavaScript
    ├── App_Start/                # Configuración MVC
    ├── Dockerfile                # ⚡ Imagen Docker del frontend
    ├── .dockerignore             # ⚡ Exclusiones Docker
    ├── Web.config                # Configuración principal
    ├── Global.asax               # Punto de entrada
    ├── neoris-pt-frontend.csproj # Archivo del proyecto
    ├── packages.config           # Paquetes NuGet
    └── README.md                 # Documentación del frontend
```

**Leyenda:** ⚡ = Nuevo en la versión Dockerizada

## 🚀 Comenzar

### Requisitos Previos

- **Visual Studio 2019 o 2022**
- **.NET Framework 4.8 Developer Pack**
- **Workload**: ASP.NET and web development

### Abrir la Solución

1. **Haz doble clic en `Neoris.sln`** (archivo en la raíz de esta carpeta)
2. O desde Visual Studio: File → Open → Project/Solution → Seleccionar `Neoris.sln`

Visual Studio cargará todos los proyectos automáticamente.

### Compilar Toda la Solución

```
En Visual Studio:
- Build → Build Solution (Ctrl+Shift+B)
- O clic derecho en la solución → Build Solution
```

### Ejecutar el Backend

```
1. En Solution Explorer, clic derecho en "neoris-pt-backend"
2. Selecciona "Set as Startup Project"
3. Presiona F5 para ejecutar
4. Ve a http://localhost:{port}/swagger para la documentación
```

## 📋 Proyectos en la Solución

### 1. neoris-pt-backend (.NET Framework 4.8)

API REST con ASP.NET Web API que expone endpoints para gestionar autores.

**Tecnologías:**
- ASP.NET Web API (.NET Framework 4.8)
- Swagger/Swashbuckle para documentación
- Newtonsoft.Json para serialización
- CORS habilitado
- JWT con OWIN

**Documentación completa:** Ver [neoris-pt-backend/README.md](neoris-pt-backend/README.md) (documentación única del backend)

**Endpoints principales:**
- `POST /api/v1/auth/login` - Emitir JWT
- `GET /api/v1/auth/me` - Usuario autenticado
- `GET /api/v1/autores` - Listar autores
- `GET /api/v1/libros` - Listar libros
- `GET /swagger` - Documentación Swagger UI

### 2. neoris-pt-frontend (ASP.NET MVC - .NET Framework 4.8)

Frontend de la aplicación desarrollado con ASP.NET MVC que consume la API REST del backend.

**Tecnologías:**
- ASP.NET MVC 5 (.NET Framework 4.8)
- Razor Views
- HttpClient para consumo de API
- CSS moderno y responsive
- JavaScript para interactividad

**DocumentacióMás Proyectos a la Solución

Si necesitas agregar más proyectos en el futuro, consulta la guía en [AGREGAR_FRONTEND.md](AGREGAR_FRONTEND.md) que incluye instrucciones detalladas

```
1. Clic derecho en la solución "Neoris"
2. Add → Existing Project
3. Navega a la carpeta del proyecto frontend
4. Selecciona el archivo .csproj (o equivalente)
```

### Opción 3: Manualmente en el .sln

Edita `Neoris.sln` y agrega una entrada para el frontend siguiendo el patrón del backend.

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

## 📦 Estructura Recomendada para el Frontend

Cuando crees el frontend, considera esta estructura:

```
neoris-pt-frontend/
├── src/
│   ├── app/
│   ├── assets/
│   ├── environments/
│   └── ...
├── package.json
├── tsconfig.json (si usas TypeScript)
└── README.md
```

## 🔗 Conectar Frontend con Backend

El frontend deberá apuntar a la URL del backend:

```javascript
// Ejemplo para Angular/React
const API_BASE_URL = 'http://localhost:5000/api';

// Ejemplo de llamada
fetch(`${API_BASE_URL}/autores`)
  .then(response => response.Actual

La solución actual contiene:

```
neoris-pt-backend/
├── Controllers/                   # API Controllers
├── Models/                        # Data models
└── ...

neoris-pt-frontend/
├── Controllers/                   # MVC Controllers
├── Views/                         # Razor Views
├── Models/                        # View models
└── ...
```

Ambos proyectos están completamente funcionales y listos para ejecutarse.Crea una rama para tu feature
2. Realiza tya está configurado para conectarse con el backend:

**Configuración en el Frontend (`Web.config`):**
```xml
<appSettings>
    <add key="ApiBaseUrl" value="http://localhost:5000/api"/>
</appSettings>
```

**Uso en los Controladores:**
```csharp
var response = await httpClient.GetAsync("/api/autores");
var autores = JsonConvert.DeserializeObject<List<Autor>>(json);
```

**Backend CORS ya configurado** en `WebApiConfig.cs`:
```csharp
var cors = new EnableCorsAttribute("*", "*", "*");
config.EnableCors(cors
**Última actualización:** Febrero 2026  
**Versión de la solución:** Visual Studio 2022
