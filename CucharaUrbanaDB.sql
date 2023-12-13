USE CucharaUrbana;

-- Crear la tabla Rol
CREATE TABLE Rol (
    RolID INT IDENTITY (1,1) PRIMARY KEY,
    NombreRol NVARCHAR(50) NOT NULL
);

-- Crear tabla Usuarios
CREATE TABLE Usuario (
    UsuarioID INT IDENTITY (1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    CorreoElectronico NVARCHAR(100) UNIQUE NOT NULL,
    RolID INT,

    FOREIGN KEY (RolID) REFERENCES Rol(RolID)
);
SELECT * FROM Usuario
-- Crear Tabla Categorias

CREATE TABLE Categoria (
	CategoriaID INT IDENTITY (1,1) PRIMARY KEY,
	Nombre VARCHAR (30),
);


-- Creacion de la tabla productos

CREATE TABLE Producto (
	ProductoID INT  IDENTITY (1,1) PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Descripcion VARCHAR (100),
	CategoriaID INT,
	CONSTRAINT fk_CategoriaID_Producto FOREIGN KEY (CategoriaID) REFERENCES Categoria(CategoriaID)
);

ALTER TABLE Producto
ADD Precio DECIMAL(10, 2);

ALTER TABLE Producto
ALTER COLUMN Descripcion VARCHAR(500);

CREATE TABLE Carrito (
    CarritoID INT IDENTITY (1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_UsuarioID_Carrito FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT fk_ProductoID_Carrito FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

-- Creaci�n de tabla Pedidos:

CREATE TABLE Pedidos (	
	PedidoID INT IDENTITY (1,1) PRIMARY KEY,
	FechaPedido  DATETIME NOT NULL,  	
	MesaPedido   INT NOT NULL,	
	UsuarioID    INT, --llave foranea del id cliente 
	EstadoPedido VARCHAR(20),
	ProductoID   INT 

	CONSTRAINT fk_UsuarioID_Pedidos FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
	CONSTRAINT fk_ProductoID_Pedidos FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);
--Creaci�n de tabla Reservaciones:

CREATE TABLE Reservacion (
	ReservacionID      INT IDENTITY (1,1) PRIMARY KEY,
	UsuarioID          INT,
	FechaReservacion   DATETIME NOT NULL,
	MesaReservacion    INT NOT NULL,
	HoraReservacion    TIME NOT NULL,
	DetalleReservacion INT NOT NULL, -- Para cuantas personas es la reserva
	
	CONSTRAINT fk_UsuarioID_Reservacion FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
	
); 

	-- Creaci�n de la tabla temporal "TipoPago" en caso de requerirse
CREATE TABLE TipoPago  (
    MetodoPagoID INT IDENTITY (1,1) PRIMARY KEY,
    TipoPago VARCHAR(50) NOT NULL
);

	-- Creaci�n de la tabla "Factura"
CREATE TABLE Factura (
    FacturaID INT IDENTITY (1,1) PRIMARY KEY,
    FechaFactura DATE NOT NULL,
    UsuarioID INT NOT NULL, --Llave foranea de la tabla Clientes para mostrar el id del cliente 
    Total DECIMAL(10, 2) NOT NULL,
    PagoID INT,
    MetodoPagoID INT,
    EstadoPago VARCHAR(20),
    TipoPagoID INT,
    CONSTRAINT fk_UsuarioID_Factura FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT fk_MetodoPagoID_Factura FOREIGN KEY (MetodoPagoID) REFERENCES TipoPago(MetodoPagoID)
);

-- Creaci�n de la tabla "DetalleFactura"
CREATE TABLE DetalleFactura (
    DetalleID INT IDENTITY (1,1) PRIMARY KEY,
    FacturaID INT,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    NombreProducto VARCHAR(50), -- Llave foranea de la tabla Productos para mostrar el nombre del producto en la factura
    TipoPagoID INT,
    CONSTRAINT fk_FacturaID_DetalleFactura FOREIGN KEY (FacturaID) REFERENCES Factura(FacturaID),
    CONSTRAINT fk_ProductoID_DetalleFactura FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    CONSTRAINT fk_TipoPagoID_DetalleFactura FOREIGN KEY (TipoPagoID) REFERENCES TipoPago(MetodoPagoID)
);



ALTER TABLE DetalleFactura
DROP COLUMN PrecioUnitario;

-- Inserts

-- Insertar datos en la tabla Rol
INSERT INTO Rol (NombreRol) VALUES ('Administrador');
INSERT INTO Rol (NombreRol) VALUES ('Usuario');

-- Insertar datos en la tabla Usuario
INSERT INTO Usuario (Nombre, Apellido, CorreoElectronico, RolID) VALUES ( 'Juan', 'Perez', 'juan@example.com', 1);
INSERT INTO Usuario (Nombre, Apellido, CorreoElectronico, RolID) VALUES ('Maria', 'Lopez', 'maria@example.com', 2);

-- Insertar datos en la tabla Categoria
INSERT INTO Categoria ( Nombre) VALUES ('Comida');
INSERT INTO Categoria ( Nombre) VALUES ('Bebida');

-- Insertar datos en la tabla Producto
INSERT INTO Producto (Nombre, Descripcion, CategoriaID, Precio) VALUES ( 'Melt Callejero', 
'Pan de molde, 2 smash de carne, 2 rebanadas de cheddar, 2 rebanadas de queso americano, cebolla lentamente caramelizada, salsa urbana y derretido en mantequilla a la plancha', 1, 4600);
INSERT INTO Producto (Nombre, Descripcion, CategoriaID, Precio) VALUES ('Urban Classic Doble', 
'Pan de papa, 2 smash de carne, 2 rebanadas de queso americano, 1 rebanada de queso cheddar, pepinilos de la casa, cebolla picada, salsa urbana', 1, 4600);
INSERT INTO Producto (Nombre, Descripcion, CategoriaID, Precio) VALUES ( 'Urban Classic Triple', 
'Pan de papa, 3 smash de carne, 2 rebanadas de queso americano, 1 rebanada de queso cheddar, pepinilos de la casa, cebolla picada, salsa urbana', 1, 5300);
INSERT INTO Producto (Nombre, Descripcion, CategoriaID, Precio) VALUES ( 'Krunchy Bella', 
'Pan de papa, 2 smash de carne, tocineta crujiente, cebolla crujiente, 1 rebanada de queso americano, 1 reabanada de queso cheddar y salsa urbana', 1, 4900);
INSERT INTO Producto (Nombre, Descripcion, CategoriaID, Precio) VALUES ( 'Juicy Luchi', 
'Pan de papa, 2 smash de carne sin vuelta, en medio 1 rebanada de cheddar y 2 de queso americano, pepinillos, cebolla picada, k�tchup y mostaza', 1, 4650);
INSERT INTO Producto (Nombre, CategoriaID, Precio) VALUES ('Extra papas fritas',  1, 1000);

SELECT * FROM Producto

DELETE FROM Producto WHERE ProductoId = 6
-- Insertar datos en la tabla TipoPago
INSERT INTO TipoPago (TipoPago) VALUES ('Efectivo');
INSERT INTO TipoPago (TipoPago) VALUES ('Tarjeta');