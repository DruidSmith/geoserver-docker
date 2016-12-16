FROM alpine

MAINTAINER Dave Smith version: 0.1

## adding ca-certificates and openssl to handle https wget download

RUN apk update \
&& apk upgrade \
&& apk add openjdk8 ca-certificates openssl

## Warning about ca-certificates.crt containing more than 1 certificate
RUN update-ca-certificates

RUN mkdir /usr/share/geoserver && mkdir /usr/tmp
## Create a tmp directory, download geoserver ZIP into it, unzip, move and delete
WORKDIR /usr/tmp
RUN wget -O geoserver_temp.zip http://downloads.sourceforge.net/project/geoserver/GeoServer/2.10.0/geoserver-2.10.0-bin.zip \
&& unzip geoserver_temp.zip && rm geoserver_temp.zip \
&& mv /usr/tmp/geoserver-2.10.0/* /usr/share/geoserver \
&& rm -rf /usr/tmp/geoserver-2.10.0

RUN wget -O importer_temp.zip http://downloads.sourceforge.net/project/geoserver/GeoServer/2.10.0/extensions/geoserver-2.10.0-importer-plugin.zip \
&& unzip importer_temp.zip && rm importer_temp.zip \
&& mv /usr/tmp/* /usr/share/geoserver/webapps/geoserver/WEB-INF/lib/ \
&& rm -rf /usr/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV JAVA_OPTS "-server -Xms128m -Xmx512m -XX:+UseParallelGC -XX:MaxPermSize=128m -XX:SoftRefLRUPolicyMSPerMB=36000"

# ENV PATH $PATH:$JAVA_HOME/bin
ENV GEOSERVER_HOME /usr/share/geoserver
ENV GEOSERVER_DATA_DIR /usr/share/geoserver/data_dir

EXPOSE 8080
EXPOSE 5432

WORKDIR /usr/share/geoserver/bin
