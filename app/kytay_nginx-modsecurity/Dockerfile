FROM ubuntu:jammy

RUN echo -e '#!/bin/bash \nexit 0' > /usr/sbin/policy-rc.d \
&& apt-get update \
&& DEBIAN_FRONTEND=noninteractive \
apt-get install --no-install-recommends -y \
curl ca-certificates apt-transport-https gnupg \
lsb-release tzdata apache2-dev apt-utils autoconf \
automake build-essential g++ git libcurl4-openssl-dev \
libgd-dev libgeoip-dev liblmdb-dev libpcre++-dev \
libpcre3 libpcre3-dev libssl-dev libtool libxml2 \
libxml2-dev libyajl-dev pkgconf uuid-dev wget zlib1g \
zlib1g-dev liblua5.3-0 liblua5.3-dev libfuzzy-dev \
libfuzzy2 libpcre2-dev libxslt-dev liblua5.3-0 \
liblua5.3-dev libfuzzy-dev libfuzzy2 libpcre2-dev \
&& ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
&& echo $TZ /etc/timezone \
&& dpkg-reconfigure --frontend noninteractive tzdata \
&& cd /usr/local/src \
&& git clone https://github.com/SpiderLabs/ModSecurity.git \
&& cd ModSecurity \
&& git submodule init \
&& git submodule update \
&& ./build.sh \
&& ./configure \
&& make \
&& make install \
&& cd /usr/local/src \
&& git clone https://github.com/SpiderLabs/ModSecurity-nginx.git \
&& cd ModSecurity-nginx \
&& git submodule init \
&& git submodule update \
&& cd /usr/local/src \
&& curl -LO https://github.com/maxmind/libmaxminddb/releases/download/1.7.1/libmaxminddb-1.7.1.tar.gz \
&& tar xvf libmaxminddb-1.7.1.tar.gz \
&& cd libmaxminddb-1.7.1 \
&& ./configure \
&& make \
&& make install \
&& cd /usr/local/src \
&& curl -LO http://nginx.org/download/nginx-1.23.3.tar.gz \
&& tar xvf nginx-1.23.3.tar.gz \
&& cd nginx-1.23.3 \
&& ./configure \
--conf-path=/etc/nginx/nginx.conf \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
--http-proxy-temp-path=/var/lib/nginx/proxy \
--http-scgi-temp-path=/var/lib/nginx/scgi \
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
--lock-path=/var/lock/nginx.lock \
--modules-path=/usr/lib/nginx/modules \
--pid-path=/run/nginx.pid \
--prefix=/usr/share/nginx \
--with-compat \
--with-debug \
--with-file-aio \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_degradation_module \
--with-http_geoip_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_v2_module \
--with-pcre-jit \
--with-stream \
--with-stream_geoip_module \
--with-stream_realip_module \
--with-stream_ssl_module \
--with-threads \
--add-dynamic-module=../ModSecurity-nginx \
&& make \
&& make install \
&& apt-get remove -y $(dpkg-query -Wf '${Package}\n' | grep -e '-dev' | tr '\n' ' ') \
&& apt-get autoremove -y \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/* \
&& cd /usr/local/src \
&& rm -Rf *

