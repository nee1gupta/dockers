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
RUN cd /tmp && tar -xvzf cxf-3.1.15.tar.gz && rm -rf cxf-3.1.15.tar.gz

COPY packages/axis2-1.6.2-bin.zip /tmp/axis2-1.6.2-bin.zip
RUN cd /tmp && unzip axis2-1.6.2-bin.zip && rm axis2-1.6.2-bin.zip
