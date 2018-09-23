FROM centos:centos7

EXPOSE 5432

RUN yum install -y  https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
RUN yum install -y epel-release 
RUN yum install -y postgresql10-server postgis25_10-utils
RUN systemctl enable postgresql-10.service

ENV PGDATA=/var/lib/pgsql/10/data/

RUN mkdir -p /var/lib/pgsql/10/data
WORKDIR /var/lib/pgsql/10/
COPY ./postgresql.conf .
COPY ./pg_hba.conf .
COPY ./start.sh .

USER postgres
CMD /var/lib/pgsql/10/start.sh
