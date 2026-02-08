-- Script de inicialización de la base de datos NeorisPTDB
USE master;
GO

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'NeorisPTDB')
BEGIN
    CREATE DATABASE NeorisPTDB;
    PRINT 'Base de datos NeorisPTDB creada exitosamente';
END
ELSE
BEGIN
    PRINT 'Base de datos NeorisPTDB ya existe';
END
GO

-- Usar la base de datos
USE NeorisPTDB;
GO


-- Crear tabla de Autores
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Autores')
BEGIN
    CREATE TABLE Autores (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Nombre NVARCHAR(100) NOT NULL,
        FechaNacimiento DATE NOT NULL,
        CiudadProcedencia NVARCHAR(100) NOT NULL,
        Email NVARCHAR(255) NOT NULL UNIQUE,
        FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
        FechaModificacion DATETIME NULL
    );
    PRINT 'Tabla Autores creada exitosamente';
END
ELSE
BEGIN
    PRINT 'Tabla Autores ya existe';
END
GO

-- Crear tabla de Libros
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Libros')
BEGIN
    CREATE TABLE Libros (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Titulo NVARCHAR(200) NOT NULL,
        Anio INT NOT NULL,
        Genero NVARCHAR(100) NOT NULL,
        NumeroPaginas INT NOT NULL,
        AutorId INT NOT NULL,
        CONSTRAINT FK_Libros_Autores FOREIGN KEY (AutorId) REFERENCES Autores(Id)
    );
    PRINT 'Tabla Libros creada exitosamente';
END
ELSE
BEGIN
    PRINT 'Tabla Libros ya existe';
END
GO


-- Insertar datos de ejemplo en Autores
IF NOT EXISTS (SELECT * FROM Autores)
BEGIN
    INSERT INTO Autores (Nombre, FechaNacimiento, CiudadProcedencia, Email)
    VALUES 
        ('Gabriel Garcia Marquez', '1927-03-06', 'Aracataca', 'gabriel.garcia@neoris.com'),
        ('Isabel Allende', '1942-08-02', 'Lima', 'isabel.allende@neoris.com'),
        ('Julio Cortazar', '1914-08-26', 'Bruselas', 'julio.cortazar@neoris.com'),
        ('Mario Vargas Llosa', '1936-03-28', 'Arequipa', 'mario.vargas@neoris.com'),
        ('Laura Esquivel', '1950-09-30', 'Ciudad de Mexico', 'laura.esquivel@neoris.com');
    PRINT 'Datos de ejemplo insertados en Autores';
END
GO

-- Insertar datos de ejemplo en Libros
IF NOT EXISTS (SELECT * FROM Libros)
BEGIN
    INSERT INTO Libros (Titulo, Anio, Genero, NumeroPaginas, AutorId)
    VALUES 
        ('Cien anos de soledad', 1967, 'Realismo magico', 432, (SELECT TOP 1 Id FROM Autores WHERE Email = 'gabriel.garcia@neoris.com')),
        ('El amor en los tiempos del colera', 1985, 'Novela', 368, (SELECT TOP 1 Id FROM Autores WHERE Email = 'gabriel.garcia@neoris.com')),
        ('La casa de los espiritus', 1982, 'Novela', 448, (SELECT TOP 1 Id FROM Autores WHERE Email = 'isabel.allende@neoris.com')),
        ('Rayuela', 1963, 'Novela', 736, (SELECT TOP 1 Id FROM Autores WHERE Email = 'julio.cortazar@neoris.com')),
        ('La ciudad y los perros', 1963, 'Novela', 448, (SELECT TOP 1 Id FROM Autores WHERE Email = 'mario.vargas@neoris.com'));
    PRINT 'Datos de ejemplo insertados en Libros';
END
GO

-- Crear indices para mejorar el rendimiento

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Autores_Email')
BEGIN
    CREATE INDEX IX_Autores_Email ON Autores(Email);
    PRINT 'Indice IX_Autores_Email creado';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Autores_Nombre')
BEGIN
    CREATE INDEX IX_Autores_Nombre ON Autores(Nombre);
    PRINT 'Indice IX_Autores_Nombre creado';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Libros_Titulo')
BEGIN
    CREATE INDEX IX_Libros_Titulo ON Libros(Titulo);
    PRINT 'Indice IX_Libros_Titulo creado';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Libros_AutorId')
BEGIN
    CREATE INDEX IX_Libros_AutorId ON Libros(AutorId);
    PRINT 'Indice IX_Libros_AutorId creado';
END
GO

PRINT 'Inicialización de base de datos completada exitosamente';
GO
