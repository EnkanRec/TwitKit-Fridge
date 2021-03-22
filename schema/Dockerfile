FROM mysql:8.0
ENV MYSQL_DATABASE='fridge_test' \
    MYSQL_USER='fridge_test' \
    MYSQL_PASSWORD='fridge_test'
COPY db_init.sql /docker-entrypoint-initdb.d