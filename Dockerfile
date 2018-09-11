FROM ubuntu:trusty

#ENV http_proxy 'http://proxy-in-noida.gemalto.com:8080/'
#ENV https_proxy 'https://proxy-in-noida.gemalto.com:8080/'
#ENV ftp_proxy 'http://proxy-in-noida.gemalto.com:8080/'
#ENV HTTP_PROXY 'http://proxy-in-noida.gemalto.com:8080/'
#ENV HTTPS_PROXY 'https://proxy-in-noida.gemalto.com:8080/'
#ENV FTP_PROXY 'http://proxy-in-noida.gemalto.com:8080/'

#ENV http_proxy 'http://Proxy-sg-singapore.gemalto.com:8080/'
#ENV https_proxy 'https://Proxy-sg-singapore.gemalto.com:8080/'
#ENV ftp_proxy 'http://Proxy-sg-singapore.gemalto.com:8080/'
#ENV HTTP_PROXY 'http://Proxy-sg-singapore.gemalto.com:8080/'
#ENV HTTPS_PROXY 'https://Proxy-sg-singapore.gemalto.com:8080/'
#ENV FTP_PROXY 'http://Proxy-sg-singapore.gemalto.com:8080/'

RUN apt-get update && apt-get install zip -y && apt-get install wget -y && apt-get install curl -y && apt-get install ant -y && apt-get install openjdk-7-jdk -y

RUN wget http://mirrors.koehn.com/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz && \
    tar xvzf apache-tomcat-8.5.23.tar.gz && \
    mv apache-tomcat-8.5.23 /opt/tomcat 

ENV CATALINA_HOME /opt/tomcat

COPY packages/axis2-1.5.4-war.zip /tmp/
RUN unzip /tmp/axis2-1.5.4-war.zip -d $CATALINA_HOME/webapps && \
    rm -rf /tmp/axis2-1.5.4-war.zip
