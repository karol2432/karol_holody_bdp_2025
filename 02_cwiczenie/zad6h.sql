WITH poly AS (
  SELECT ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))') AS geom
),
building_c AS (
  SELECT geometry FROM buildings
  WHERE name = 'BuildingC'
)
SELECT ST_Area(
  ST_Difference( 
  ST_Union(a.geometry, b.geom), 
  ST_Intersection(a.geometry, b.geom))) AS area
FROM building_c a, poly b;