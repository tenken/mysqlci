# DPG 09-20-2019
# https://stackoverflow.com/a/54034654/1491507

FROM mysql:8.0

RUN echo '[mysqld]' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'default-authentication-plugin = mysql_native_password' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'collation-server = utf8mb4_general_ci' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'character-set-server = utf8mb4' >> /etc/mysql/conf.d/mysql.cnf
