FROM centos:7
MAINTAINER Gilberto Asuaje <asuajegilberto@gmail.com>
#install php 7
RUN yum -y update &&\
    yum -y install vim wget && \
    yum -y install epel-release yum-utils && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php73 && \
    yum -y install php php-json php-pecl-apcu-bc php-process php-pdo php-intl php-cli php-pecl-apcu php-xml php-pgsql php-mysql php-mcrypt php-soap php-pear php-mbstring php-common php-devel php-opcache php-gd php-bcmath php-zip php-xdebug&& \
    yum install -y httpd && \
    yum -y install vim git zip unzip

#digest
RUN mkdir /etc/usuario_digest && \ 
    touch /etc/usuario_digest/auth_digest && \
#ajustamos permisos 
    chown -R apache:apache /var/www/html/ && \
    chown -R apache:apache /var/lib/php/session 
#agregamos archivos de configuracion
COPY includes/* /tmp/ 
RUN mv /tmp/php.ini /etc/ && \
    mv /tmp/httpd.conf /etc/httpd/conf/ && \
    mv /tmp/run-httpd.sh /run-httpd.sh && \   
    chmod -v +x /run-httpd.sh
# Set this environment variable to true to set timezone on container start.
ENV TZ=America/Guayaquil
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#arrancamos apache
CMD ["/run-httpd.sh"]
EXPOSE 80
EXPOSE 3000
