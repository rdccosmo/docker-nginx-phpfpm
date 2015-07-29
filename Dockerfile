FROM million12/centos-supervisor 
MAINTAINER Rodrigo Cosme <rdccosmo@gmail.com>
RUN yum install -y \
    php \
    php-fpm \
    php-cli \
    php-mysql \
    php-mbstring \
    php-common \
    php-pdo \
    php-gd \
    php-ldap \
    php-xml \
    nginx \
    nodejs 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d
COPY php-fpm/php.ini /etc/php.ini
COPY php-fpm/php-fpm.conf /etc/php-fpm.conf
COPY php-fpm/php-fpm.d /etc/php-fpm.d
ADD supervisord/nginx-service.conf /etc/supervisor.d/nginx-service.conf
ADD supervisord/php-fpm-service.conf /etc/supervisor.d/php-fpm-service.conf
ADD supervisord/php.sh /php.sh
RUN chmod +x /php.sh
ADD supervisord/php-service.conf /etc/supervisor.d/php-service.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log 

WORKDIR /var/www/html
VOLUME /var/www/html
EXPOSE 80

