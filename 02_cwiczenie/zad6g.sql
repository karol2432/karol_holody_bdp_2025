WITH centroid_by AS (
SELECT ST_Y(ST_Centroid(geometry)) AS y, name, id, geometry
FROM buildings
),
road_y AS (
SELECT ST_Y(ST_Centroid(geometry)) AS y FROM roads
WHERE name = 'RoadX'
)

SELECT centroid_by.id, centroid_by.name, ST_AsText(centroid_by.geometry), centroid_by.y 
FROM centroid_by, road_y
WHERE centroid_by.y > road_y.y;