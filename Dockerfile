# DPG 09-20-2019
# https://stackoverflow.com/a/54034654/1491507

FROM mysql:8.0 as upstream

FROM scratch
COPY --from=upstream / /

ENV GOSU_VERSION 1.7
ENV MYSQL_MAJOR 8.0
ENV MYSQL_VERSION 8.0.18-1debian9

RUN echo '[mysqld]' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'default-authentication-plugin = mysql_native_password' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'collation-server = utf8mb4_general_ci' >> /etc/mysql/conf.d/mysql.cnf
RUN echo 'character-set-server = utf8mb4' >> /etc/mysql/conf.d/mysql.cnf

VOLUME /var/lib/mysql

ENTRYPOINT ["docker-entrypoint.sh"]

# Try to remove skip-symbolic-links from startup configuration
# https://serverfault.com/a/705609
RUN echo "symbolic-links=FALSE" >> /etc/mysql/conf.d/docker.cnf

# 01-02-2019 DPG slow updates in mysql8
# https://dba.stackexchange.com/questions/232365/mysql-8-0-updates-are-sometimes-stalling
RUN echo "range-optimizer-max-mem-size=0" >> /etc/mysql/conf.d/docker.cnf


# only expose port 3306, but not 33060,
# as the upstream Dockerfile does
# https://github.com/docker-library/mysql/blob/master/8.0/Dockerfile#L74
# this is to address the following gitlab-runner error
# https://gitlab.com/gitlab-org/gitlab-runner/issues/4143
EXPOSE 3306

CMD ["mysqld"]
