-- zad1
SELECT b2019.* 
FROM t2019_kar_buildings AS b2019 
LEFT JOIN t2018_kar_buildings AS b2018 
  ON ST_Equals(b2019.geom, b2018.geom) 
WHERE b2018.geom IS NULL;  -- jeśli nie znaleziono w 2018, to budynek jest nowy 

--zad2
WITH new_buildings AS (
    SELECT b2019.*
    FROM t2019_kar_buildings AS b2019
    LEFT JOIN t2018_kar_buildings AS b2018
      ON ST_Equals(b2019.geom, b2018.geom)
    WHERE b2018.geom IS NULL
),
new_pois AS (
    SELECT p2019.*
    FROM t2019_kar_poi AS p2019
    LEFT JOIN t2018_kar_poi AS p2018
      ON ST_Equals(p2019.geom, p2018.geom)
    WHERE p2018.geom IS NULL
)
SELECT np.type, COUNT(*) AS poi_count
FROM new_pois np
JOIN new_buildings nb
  ON ST_Distance(np.geom, nb.geom) <=500
GROUP BY np.type;

--zad3   DHDN.Berlin/Cassini - EPSG:3068

CREATE TABLE streets_reprojected AS
SELECT *, ST_Transform(geom,3068) AS geom_reprojected
FROM t2019_streets

-- zad4
CREATE TABLE input_points(
point_id SERIAL PRIMARY KEY,
geom geometry(Point)
);

INSERT INTO input_points
VALUES
(1,ST_MakePoint(8.36093, 49.03174)),
(2,ST_MakePoint(8.39876, 49.00644));

--zad5
UPDATE input_points
SET geom=ST_SetSRID(geom,3068);

SELECT * FROM input_points;

--zad6

WITH rep_nodes AS(
SELECT node_id, ST_Transform(geom,3068) AS geom
FROM t2019_street_node
),
point_line AS(
SELECT ST_MakeLine(geom ORDER BY point_id) AS geom
FROM input_points
)
SELECT *
FROM rep_nodes n, point_line l
WHERE ST_DWithin(n.geom, l.geom, 200);

--zad7 sklepy sportowe w odlegl 300m od parkow
SELECT COUNT(*) AS shops_close_to_parks
FROM t2019_kar_poi p
JOIN t2019_land_use l
ON ST_DWithin(
	ST_Transform(p.geom, 3068),
    ST_Transform(l.geom, 3068),
    300)
WHERE p.type = 'Sporting Goods Store' AND l.type= 'Park (City/County)';

--zad8 
CREATE TABLE IF NOT EXISTS T2019_KAR_BRIDGES AS
SELECT 
ST_Intersection(r.geom, w.geom) AS geom
FROM t2019_railways r
JOIN t2019_waterlines w
ON  ST_Intersects(r.geom,w.geom);

SELECT geom FROM T2019_KAR_BRIDGES;

