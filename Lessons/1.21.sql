CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

-- DROP DATABASE IF EXISTS jobs_mart;

SELECT *
FROM information_schema.tables;
WHERE table_catalog = 'jobs_mart';

USE jobs_mart; 

CREATE SCHEMA IF NOT EXISTS staging;


-- DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER,
    role_name VARCHAR
);


-- DROP TABLE main.preffered_roles;


INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer');

SELECT *   
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;


UPDATE staging.preferred_roles
SET preferred_role = True
WHERE role_id = 1 OR role_id=2;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *   
FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role to priority_1v1;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_1v1 TYPE INTEGER;