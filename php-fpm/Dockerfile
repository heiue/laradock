ARG PHP_VERSION
FROM registry.cn-beijing.aliyuncs.com/liuqinghui/php-dev-env:php-fpm-${PHP_VERSION}
LABEL maintainer="liuqinghui <liuqinghui1991@163.com>"

# 配置同步
#COPY  ./laravel.ini /usr/local/etc/php/conf.d
#COPY  ./opcache.ini /usr/local/etc/php/conf.d
#COPY  ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
#COPY  ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/


###########################################################################
# YAF:
###########################################################################
USER root

ARG INSTALL_YAF=true

RUN if [ ${INSTALL_YAF} = true ]; then \
    # cd /tmp && \
    # yum http://pecl.php.net/get/yaf-3.1.3.tgz \
    # tar -zxvf yaf-3.1.3.tgz \
    # cd yaf-3.1.3 && \
    # phpize && \
    # ./configure && \
    # make && \
    # make install && \
    # rm -rf /tmp/yaf-3.1.3 \
    pecl install yaf-3.1.3 && \
    docker-php-ext-enable yaf; \
    php -m | grep -q 'yaf' \
;fi

###########################################################################
# LDAP:
###########################################################################
ARG INSTALL_LDAP=true

RUN if [ ${INSTALL_LDAP} = true ]; then \
    # pecl install ldap && \
    # docker-php-ext-enable ldap \
    apt-get update && \
    apt-get install -yqq libldap2-dev && \
    # docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap \
;fi

###########################################################################
# SEASLOG:
###########################################################################

ARG INSTALL_SEASLOG=true

RUN if [ ${INSTALL_SEASLOG} = true ]; then \
    pecl install seaslog && \
    docker-php-ext-enable seaslog \
;fi


# 设置时区
ARG TZ=PRC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /data/wwwroot
