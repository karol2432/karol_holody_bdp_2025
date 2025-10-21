WITH building_b AS(
	SELECT ST_Buffer(geometry, 0.5) AS geometry FROM buildings
	WHERE name = 'BuildingB'
), 
building_c AS(
	SELECT geometry FROM buildings
	WHERE name = 'BuildingC'
)

SELECT ST_Area(ST_Difference(building_b.geometry, building_c.geometry)) AS Area
FROM building_b, building_c;