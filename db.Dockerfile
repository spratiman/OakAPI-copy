FROM postgres:9.4
ADD db/init.sql /docker-entrypoint-initdb.d/
