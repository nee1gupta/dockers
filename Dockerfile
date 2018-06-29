FROM centos:7
RUN yum  update -y && \
    yum -y install perl && \
    yum -y install gcc && \
    yum -y install make && \
    yum -y install gcc-c++ && \
    yum -y install openssh-clients && \
    yum -y install openssl-devel && \
    yum -y install glibc-devel && \
    yum -y install libssl-dev && \
    yum -y install net-tools && \
    yum -y install wget && \
    yum -y install ant && \
    yum -y install zip && \
    yum -y install unzip && \
    yum -y install glibc.i686
