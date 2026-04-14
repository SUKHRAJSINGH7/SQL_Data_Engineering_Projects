 CREATE OR REPLACE TABLE staging.priority_roles (
    role_id     INTEGER PRIMARY KEY,
    role_name   VARCHAR,
    priority_1v1 INTEGER
 ); 
 
 INSERT INTO staging.priority_roles (role_id, role_name, priority_1v1)
 VALUES
    (1, 'Data Engineer', 1),
    (2, 'Senior Data Engineer', 1),
    (3, 'Software Engineer', 3),
    (4, 'Data Scientist', 3);

SELECT * FROM staging.priority_roles; 