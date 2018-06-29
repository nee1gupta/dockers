FROM centos:7
 RUN yum  update -y && \
    yum install perl -y && \
    yum install gcc -y && \
    yum install make -y && \
    yum install gcc-c++ -y && \
    yum install openssh-clients -y && \
    yum install openssl-devel -y && \
    yum install glibc-devel -y && \
    yum install net-tools -y && \
    yum install wget -y && \
    yum install ant -y && \
    yum install zip -y && \
    yum install unzip -y && \
    yum install glibc.i686 -y

COPY packages/jdk-7-linux-x64.tar.gz /tmp/jdk-7-linux-x64.tar.gz
RUN cd /tmp && tar -xvzf jdk-7-linux-x64.tar.gz -C /usr && rm /tmp/jdk-7-linux-x64.tar.gz
ENV JAVA_HOME /usr/jdk1.7.0

COPY packages/cxf-3.1.15.tar.gz /tmp/cxf-3.1.15.tar.gz
RUN tar -xvzf /tmp/cxf-3.1.15.tar.gz -C /opt/ && rm -rf /tmp/cxf-3.1.15.tar.gz
ENV CXF_HOME /opt/cxf-cxf-3.1.15

COPY packages/axis2-1.6.2-bin.zip /opt/axis2-1.6.2-bin.zip
RUN cd /opt && unzip axis2-1.6.2-bin.zip && rm axis2-1.6.2-bin.zip
