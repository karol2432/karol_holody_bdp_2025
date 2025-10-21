CREATE EXTENSION postgis;

CREATE TABLE buildings (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32),
    geometry geometry
);

CREATE TABLE roads (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32),
    geometry geometry
);

CREATE TABLE poi (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32),
    geometry geometry
);