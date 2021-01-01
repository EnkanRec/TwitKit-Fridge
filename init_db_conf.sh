#!/bin/bash -e
BASEPATH=$(cd `dirname $0`; pwd)
if [ -n "$1" ]; then
    DB="$1"
else
    DB="twitkit-$USER"
fi
if [ -n "$2" ]; 
    PASS="$2"
else
    PASS=`date|md5sum|head -c16`
fi

mysql -u root -p << MYSQL_SCRIPT
CREATE DATABASE $DB;
CREATE USER '$DB'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $DB.* TO '$DB'@'localhost';
FLUSH PRIVILEGES;
USE $DB;
SOURCE $BASEPATH/schema/db_init.sql;
MYSQL_SCRIPT

echo 'Config created:'
tee application.properties << EOF
# 数据源
spring.datasource.yui.jdbc-url=jdbc:mysql://localhost:3306/$DB?characterEncoding=utf-8&useSSL=true&serverTimezone=Asia/Shanghai
spring.datasource.yui.username=$DB
spring.datasource.yui.password=$PASS
EOF