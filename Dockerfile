# DPG 09-20-2019
# https://stackoverflow.com/a/54034654/1491507

FROM mysql:8.0

RUN echo '[mysqld]' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'default-authentication-plugin = mysql_native_password' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'collation-server = utf8mb4_general_ci' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'character-set-server = utf8mb4' >> /etc/mysql/conf.d/mysql.cnf

# only expose port 3306, but not 33060,
# as the upstream Dockerfile does
# https://github.com/docker-library/mysql/blob/master/8.0/Dockerfile#L74
# this is to address the following gitlab-runner error
# https://gitlab.com/gitlab-org/gitlab-runner/issues/4143
EXPOSE 3306
