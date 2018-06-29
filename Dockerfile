FROM centos:7
RUN yum -y update && \
    yum -y install perl && \
    yum -y install gcc && \
    yum -y install make && \
    yum -y install wget && \
    yum -y install ant && \
    yum -y install zip && \
    yum -y install unzip && \
    yum -y install glibc.i686

ADD packages/jdk-7-linux-x64.tar.gz /tmp/jdk-7-linux-x64.tar.gz
RUN cd /tmp && tar -xvzf jdk-7-linux-x64.tar.gz -C /usr && rm /tmp/jdk-7-linux-x64.tar.gz
ENV JAVA_HOME /usr/jdk1.7.0

ADD packages/cxf-3.1.15.tar.gz /tmp/cxf-3.1.15.tar.gz
RUN cd /tmp && tar -xvzf cxf-3.1.15.tar.gz && rm -rf cxf-3.1.15.tar.gz

ADD packages/axis2-1.6.2-bin.zip /tmp/axis2-1.6.2-bin.zip
RUN cd /tmp && unzip axis2-1.6.2-bin.zip && rm axis2-1.6.2-bin.zip
