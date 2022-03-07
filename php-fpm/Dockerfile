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

###########################################################################
# Xhprof:
###########################################################################

ARG INSTALL_XHPROF=false

RUN if [ ${INSTALL_XHPROF} = true ]; then \
    # Install the php xhprof extension
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = 7 ]; then \
      curl -L -o /tmp/xhprof.tar.gz "https://github.com/tideways/php-xhprof-extension/archive/v5.0.1.tar.gz"; \
    else \ 
      curl -L -o /tmp/xhprof.tar.gz "https://codeload.github.com/phacility/xhprof/tar.gz/master"; \
    fi \
    && mkdir -p xhprof \
    && tar -C xhprof -zxvf /tmp/xhprof.tar.gz --strip 1 \
    && ( \
        cd xhprof \
        && phpize \
        && ./configure \
        && make \
        && make install \
    ) \
    && rm -r xhprof \
    && rm /tmp/xhprof.tar.gz \
;fi

# COPY ./xhprof.ini /usr/local/etc/php/conf.d
# RUN if [ ${INSTALL_XHPROF} = false ]; then \
    # rm /usr/local/etc/php/conf.d/xhprof.ini \
# ;fi

###########################################################################
# GRPC:
###########################################################################

ARG INSTALL_GRPC=true

RUN if [ ${INSTALL_GRPC} = true ]; then \
    pecl install grpc-1.42.0 && \
    docker-php-ext-enable grpc \
;fi

###########################################################################
# 常用命令安装:
###########################################################################
ARG BASH=true

RUN if [ ${BASH} = true ]; then \
    apt-get update && \
    apt-get -f -y --force-yes install graphviz \
;fi

# 设置时区
ARG TZ=PRC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /data/wwwroot
