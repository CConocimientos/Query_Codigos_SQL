
-- 1. Consulta simple con SELECT*
SELECT * FROM Productos;

-- 2. Consulta filtrada con índice
SELECT Nombre, Precio 
FROM Productos 
WHERE Precio > 10;

-- 3. Subconsulta vs JOIN (comparar planes)
SELECT Nombre 
FROM Productos 
WHERE ProveedorID IN (
    SELECT ProveedorID 
    FROM Proveedores 
    WHERE Nombre = 'Ward Group'
);

SELECT p.Nombre 
FROM Productos p
JOIN Proveedores pr ON p.ProveedorID = pr.ProveedorID
WHERE pr.Nombre = 'Ward Group';

--4. Consulta sin índice en columna filtrada
SELECT * 
FROM Pedidos 
WHERE [FechaPedido] = '2024-01-01';

-- 5. Consulta con función en WHERE (menos eficiente)
SELECT * 
FROM Productos 
WHERE YEAR(FechaIngreso) = 2024;

-- 