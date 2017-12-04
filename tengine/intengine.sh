#!/bin/bash
###tengine安装脚本####
yum -y install gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel pcre* jemalloc jemalloc-devel
PKG_PATH=/opt/tengine_install
WEB_ROOT=/app/www
tar -zxvf "$PKG_PATH"/pcre-8.38.tar.gz -C /usr/local/src
useradd -s /sbin/nologin www
tar -zxvf "$PKG_PATH"/tengine-2.1.2.tar.gz -C $PKG_PATH
cd  "$PKG_PATH"/tengine-2.1.2
sed -i 's/#define NGINX_VERSION      ".*"/#define NGINX_VERSION      "1.0.1"/'             src/core/nginx.h
sed -i 's$#define NGINX_VER          ".*/"$#define NGINX_VER          "X-web/"$'    src/core/nginx.h
sed -i 's/#define TENGINE            ".*"/#define TENGINE      "X-web"/'      src/core/nginx.h
sed -i 's/#define TENGINE_VERSION    ".*"/#define TENGINE_VERSION      "1.0.1"/'             src/core/nginx.h
./configure --prefix=/usr/local/nginx --with-http_dav_module --with-http_stub_status_module --with-http_addition_module --with-http_sub_module --with-jemalloc --with-http_flv_module  --with-http_mp4_module --with-pcre=/usr/local/src/pcre-8.38 --user=www --group=www
[ ! $? -eq 0 ] && echo "CONFIG Failed" && exit 9
make && make install
[ -f /usr/local/bin/nginx ] && mv -f /usr/local/bin/nginx /tmp
ln -s /usr/local/nginx/sbin/nginx  /usr/local/bin/nginx
[ -d $WEB_ROOT ] && echo "Web Root Dir /opt/www  is Exsit " && mv -f $WEB_ROOT /tmp
[ ! -d "$WEB_ROOT"/images ] && mkdir -p "$WEB_ROOT"/images
[ ! -d "$WEB_ROOT"/webfile ] && mkdir -p "$WEB_ROOT"/webfile
[ -d /usr/local/nginx/conf/conf.d ] && echo "conf.d Dir is Exsit" && mv -f /usr/local/nginx/conf/conf.d /tmp
[ -f /usr/local/nginx/conf/upstream.conf ] && echo "Upsteam.conf is Exsit" && mv -f /usr/local/nginx/conf/upstream.conf /tmp
cp "$PKG_PATH"/404.html /usr/local/nginx/html
mv -f "$PKG_PATH"/nginx.conf /usr/local/nginx/conf/nginx.conf
cp -r  "$PKG_PATH"/conf.d    /usr/local/nginx/conf/
cp  "$PKG_PATH"/upstream.conf /usr/local/nginx/conf/
cp  "$PKG_PATH"/nginx /etc/init.d/
chmod +x /etc/init.d/nginx
service nginx start
ulimit -n 65535
echo "ulimit -n 65535" >> /etc/rc.local
echo "/etc/init.d/nginx start" >> /etc/rc.local
