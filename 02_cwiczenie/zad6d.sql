SELECT name, ST_Perimeter(geometry) AS Perimeter FROM buildings
ORDER BY ST_Area(geometry) DESC
LIMIT 2;