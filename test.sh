docker exec -it pg-master psql -U postgres -d mydb

docker exec -it pg-slave psql -U postgres -d mydb

CREATE TABLE test (id SERIAL PRIMARY KEY, data TEXT);

INSERT INTO test (data) VALUES ('Hello, World!');

select * from test;