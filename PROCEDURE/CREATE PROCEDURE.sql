
-- 1. SP sin parámetro de entrada — Para reportes generales

CREATE PROCEDURE sp_ReporteProductosDisponibles
AS
BEGIN
    SELECT Nombre, Precio, Stock
    FROM Productos
    WHERE Stock > 0;
END

-- 2. SP con parámetro de entrada — Buscar datos por fecha

CREATE PROCEDURE sp_PedidosPorFecha
    @Fecha DATE
AS
BEGIN
    SELECT *
    FROM Pedidos
    WHERE CAST(FechaPedido AS DATE) = @Fecha;
END

-- 3. SP con parámetro de salida — Insertar registros desde una web y devolver el ID
CREATE PROCEDURE sp_InsertarCliente
    @Nombre NVARCHAR(100),
    @Correo NVARCHAR(100),
    @NuevoID INT OUTPUT
AS
BEGIN
    INSERT INTO Clientes (Nombre, Correo)
    VALUES (@Nombre, @Correo);

    SET @NuevoID = SCOPE_IDENTITY();
END
