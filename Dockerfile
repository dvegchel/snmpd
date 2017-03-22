FROM centos:latest
MAINTAINER Denzel van Vegchel <denzel.vanvegchel@openline.nl>

EXPOSE 161 161/udp
WORKDIR /tmp

RUN > /var/log/yum.log && \
    yum install -y make \
		   gcc \
		   gcc-c++ \
		   zlib-devel \
		   perl-ExtUtils-Embed \
		   perl-devel \
		   file


RUN curl -L -o net-snmp-5.7.3.tar.gz 'https://github.com/dvegchel/snmpd/raw/master/net-snmp-5.7.3-patched.tar.gz' && \
    tar zxf net-snmp-5.7.3.tar.gz
    
RUN cd net-snmp-5.7.3 && \
    ./configure --prefix=/usr/local --disable-ipv6 --disable-snmpv1 --with-defaults && \
    make && \
    make install

ADD snmpd.conf /usr/local/etc/snmpd.conf

CMD [ "/usr/local/sbin/snmpd", "-f", "-c", "/usr/local/etc/snmpd.conf" ]
