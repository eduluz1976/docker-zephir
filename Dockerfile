FROM ubuntu

LABEL MAINTAINER="Eduardo Luz <eduardo@eduardo-luz.com>"
LABEL VERSION="0.0.2"

RUN  export DEBIAN_FRONTEND=noninteractive \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && apt-get update \
    && apt-get install -y php-dev gcc make re2c php-json libpcre3-dev  build-essential  autoconf automake tzdata git vim \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && git clone git://github.com/phalcon/php-zephir-parser.git \
    && cd php-zephir-parser \
    && phpize \
    && ./configure \ 
    && make \
    && make install 

COPY zephir.ini /etc/php/7.4/mods-available

RUN ln -fs /etc/php/7.4/mods-available/zephir.ini /etc/php/7.4/cli/conf.d/30-zephir.ini

COPY zephir.phar /usr/bin/zephir 
RUN chmod 755 /usr/bin/zephir
