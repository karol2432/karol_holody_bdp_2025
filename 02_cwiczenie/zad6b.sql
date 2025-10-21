SELECT name, ST_AsText(geometry) AS wkt, ST_Area(geometry) AS Area, ST_Perimeter(geometry) AS Perimeter FROM buildings
WHERE name = 'BuildingA';