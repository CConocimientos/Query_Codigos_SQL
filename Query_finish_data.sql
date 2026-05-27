-- ══════════════════════════════════════════════
-- REPORTE EJECUTIVO: INVENTARIO POR PROVEEDOR
-- Resumen para gerencia - BD_SISTEMAVENTA
-- ══════════════════════════════════════════════

SELECT 
    -- Datos del Proveedor
    b.Nombre                        AS Proveedor,
    b.Contacto,
    b.Telefono,

    -- Métricas de Inventario
    COUNT(a.ProductoID)             AS Total_Productos,
    SUM(a.Stock)                    AS Stock_Total,
    AVG(a.Precio)                   AS Precio_Promedio,
    MIN(a.Precio)                   AS Precio_Minimo,
    MAX(a.Precio)                   AS Precio_Maximo,

    -- Valor total del inventario
    SUM(a.Stock * a.Precio)         AS Valor_Inventario,

    -- Productos con stock bajo (alerta)
    SUM(CASE WHEN a.Stock < 100 
        THEN 1 ELSE 0 END)          AS Productos_Stock_Bajo

FROM [BD_SISTEMAVENTA].[dbo].[Productos] AS a
JOIN [dbo].[Proveedores] AS b 
    ON a.ProveedorID = b.ProveedorID

GROUP BY 
    b.Nombre, 
    b.Contacto, 
    b.Telefono

ORDER BY 
    Valor_Inventario DESC;