SELECT ST_Distance(b.geometry, p.geometry) as dist
FROM buildings b
JOIN poi p ON p.name='K'
WHERE b.name='BuildingC';