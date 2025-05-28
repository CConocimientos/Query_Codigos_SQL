-- Ejemplo 1: Clasificar productos según el stock

SELECT 
  Nombre,
  Stock,
  CASE 
    WHEN Stock > 200 THEN 'Alto stock'
    WHEN Stock BETWEEN 100 AND 200 THEN 'Stock medio'
    ELSE 'Stock bajo'
  END AS NivelStock
FROM dbo.Productos;

-- Ejemplo 2: Empleados cuyo salario es Alto, Intermedio, Bajo

SELECT [Nombre]
      ,[Cargo]
      ,[Salario]
	  ,CASE 
	  WHEN [Salario] between 6000 and 10000 THEN 'Alto'
	  WHEN [Salario] between 3000 and 5999 THEN 'Intermedio'
	  ELSE 'Bajo'
	  END AS Nivel
FROM [SistemaVentas].[dbo].[Empleados]