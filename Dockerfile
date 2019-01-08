FROM centos:centos7

EXPOSE 5432

ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN groupadd -r -g 1500 postgres
RUN useradd -r -u 1501 -g postgres postgres 

RUN yum install -y https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm
# RUN yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
RUN yum install -y epel-release 
RUN yum install -y gdal geos proj4
RUN yum install -y postgresql11-server postgis24_11-utils

WORKDIR /var/lib/pgsql/11/
USER postgres
COPY ./postgresql.conf .
COPY ./pg_hba.conf .
COPY ./start.sh .

CMD /var/lib/pgsql/11/start.sh

