--CREATE FUNCTION dbo.CalcularIGV (@precio DECIMAL(10,2))
--RETURNS DECIMAL(10,2)
--AS
--BEGIN
--    RETURN @precio * 0.18
--END;


SELECT Nombre, Precio, dbo.CalcularIGV(Precio) AS IGV
-- select *
FROM Productos;


--CREATE FUNCTION dbo.FormatearNombre (@nombre NVARCHAR(100))
--RETURNS NVARCHAR(100)
--AS
--BEGIN
--    RETURN UPPER(LEFT(@nombre, 1)) + LOWER(SUBSTRING(@nombre, 2, LEN(@nombre)))
--END;

SELECT dbo.FormatearNombre(Nombre) AS NombreFormateado
FROM Clientes;


--CREATE FUNCTION dbo.ProductosDelAnio()
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT *
--    FROM Productos
--    WHERE YEAR(FechaIngreso) = YEAR(GETDATE())
--);

SELECT * FROM dbo.ProductosDelAnio();
