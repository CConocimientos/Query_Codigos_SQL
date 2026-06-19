create or alter procedure usp_Registrar_ventas
@clienteId INT,
@nombre VARCHAR(100),
@Ciudad    VARCHAR(50),
@Categoria VARCHAR(50),
@Producto  VARCHAR(100),
@Vendedor  VARCHAR(100),
@Cantidad  INT,
@Precio    DECIMAL(10,2)
as
begin
SET NOCOUNT ON;
DECLARE @total DECIMAL(10,2);
DECLARE @VentaID INT 

BEGIN TRANSACTION
BEGIN TRY

--VALIDACIONES
        IF @Cantidad <= 0
            THROW 50001, 'La cantidad debe ser mayor a cero', 1;

        IF @Precio <= 0
            THROW 50002, 'El precio debe ser mayor a cero', 1;

        IF @Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = ''
            THROW 50003, 'El nombre del cliente es obligatorio', 1;

        IF @Producto IS NULL OR LTRIM(RTRIM(@Producto)) = ''
            THROW 50004, 'El producto es obligatorio', 1;

        IF @Vendedor IS NULL OR LTRIM(RTRIM(@Vendedor)) = ''
            THROW 50005, 'El vendedor es obligatorio', 1;

-- CALCULOS AUTOMATICOS
        SET @Total = @Cantidad * @Precio;
	SELECT @VentaID = ISNULL(MAX(VentaID),0) + 1
FROM ventas_limpias;

        -- INSERTAR LA VENTA
        INSERT INTO ventas_limpias_new (
            ClienteID, Nombre, Ciudad,
            Categoria, Producto, Vendedor,
            Cantidad, Precio, Total,
            Fecha, Anno, Mes, NombreMes,
            Trimestre, DiaSemana, FechaCarga
        )
        VALUES (
            @ClienteID, @Nombre, @Ciudad,
            @Categoria, @Producto, @Vendedor,
            @Cantidad, @Precio, @Total,
            CAST(GETDATE() AS DATE),
            YEAR(GETDATE()),
            MONTH(GETDATE()),
            DATENAME(MONTH,   GETDATE()),
            DATEPART(QUARTER, GETDATE()),
            DATENAME(WEEKDAY, GETDATE()),
            GETDATE()
        );

COMMIT TRANSACTION;

        SELECT
            'Venta registrada exitosamente' AS Resultado,
            @VentaID                        AS VentaID_Generado,
            @Nombre                         AS Cliente,
            @Producto                       AS Producto,
            @Cantidad                       AS Cantidad,
            @Precio                         AS Precio_Unitario,
            @Total                          AS Total_Venta,
            CAST(GETDATE() AS DATE)         AS Fecha_Venta,
            @Vendedor                       AS Vendedor;

END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO LogErrores (Proceso, Mensaje)
        VALUES ('usp_RegistrarVenta', ERROR_MESSAGE());

        SELECT
            'ERROR - Venta NO registrada' AS Resultado,
            ERROR_MESSAGE()               AS Detalle_Error;

    END CATCH
END;
GO