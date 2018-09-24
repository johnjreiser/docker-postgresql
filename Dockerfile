FROM centos:centos7

EXPOSE 5432

RUN groupadd -r -g 1500 postgres
RUN useradd -r -u 1501 -g postgres postgres 

RUN yum install -y  https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
RUN yum install -y epel-release 
RUN yum install -y postgresql10-server postgis25_10-utils

ENV PGDATA=/var/lib/pgsql/10/data/

USER postgres
WORKDIR /var/lib/pgsql/
COPY ./postgresql.conf .
COPY ./pg_hba.conf .
COPY ./start.sh .

CMD /var/lib/pgsql/start.sh
