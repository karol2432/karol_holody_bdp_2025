DROP TABLE IF EXISTS obiekty;
CREATE TABLE obiekty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32),
    geometry GEOMETRY
);

INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt1',
    ST_GeomFromText(
        'COMPOUNDCURVE(
            (0 1, 1 1),
            CIRCULARSTRING(1 1, 2 0, 3 1),
            CIRCULARSTRING(3 1, 4 2, 5 1),
            (5 1, 6 1)
        )'
    )
);


INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt2',
    ST_GeomFromText(
        'CURVEPOLYGON(
             (10 6, 14 6, 16 4, 14 2, 12 0, 10 2, 10 6),
             (13 2, 12 3, 11 2, 12 1, 13 2)
         )'
        
    )
);

INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt3',
    ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))')
);

INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt4',
    ST_LineFromMultiPoint(ST_GeomFromText('MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'))
);

INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt5',
    ST_GeomFromText('MULTIPOINT Z((30 30 59), (38 32 234))')
);

INSERT INTO obiekty (name, geometry)
VALUES (
    'obiekt6',
    ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))')
);

-- Zad2
SELECT ST_Area(
    ST_Buffer(
        ST_ShortestLine(a.geometry, b.geometry), 5)
)
FROM obiekty a, obiekty b
WHERE a.name = 'obiekt3' AND b.name = 'obiekt4';


-- zad3
WITH pol_geom AS (
	SELECT ST_MakePolygon(ST_AddPoint(geometry, ST_StartPoint(geometry)))
	FROM obiekty
	WHERE "name" = 'obiekt4'
)

UPDATE obiekty
SET geometry = (SELECT * FROM pol_geom)
WHERE "name" = 'obiekt4';
SELECT * FROM obiekty;


-- zad4
INSERT INTO obiekty (nazwa, geometria)
SELECT 
    'obiekt7',
    ST_Union(a.geometria, b.geometria)
FROM obiekty a, obiekty b
WHERE a.name = 'obiekt3' AND b.name = 'obiekt4';



--zad5
SELECT name, ST_Area(ST_Buffer(geometry,5)) AS Pole
FROM obiekty
WHERE NOT ST_HasArc(geometry);