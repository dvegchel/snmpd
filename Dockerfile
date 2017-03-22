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


RUN curl -L -o net-snmp-5.7.3.tar.gz 'http://downloads.sourceforge.net/project/net-snmp/net-snmp/5.7.3/net-snmp-5.7.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fnet-snmp%2Ffiles%2Fnet-snmp%2F5.7.3%2F&ts=1443006025&use_mirror=skylink' && \
    tar zxf net-snmp-5.7.3.tar.gz

ADD apply_patch.sh /tmp/apply_patch.sh

RUN cd net-snmp-5.7.3 && \
    ../apply_patch.sh
    
RUN cd net-snmp-5.7.3 && \
    ./configure --prefix=/usr/local --disable-ipv6 --disable-snmpv1 --with-defaults && \
    make && \
    make install

ADD snmpd.conf /usr/local/etc/snmpd.conf

CMD [ "/usr/local/sbin/snmpd", "-f", "-c", "/usr/local/etc/snmpd.conf" ]
