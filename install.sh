#bin/bash

#install dependencies
sudo apt-get install unzip zlibc zlib1g build-essential zlib1g-dev libpcre3 libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev curl

#nginx version
NGINX_VERSION=1.12.1

#openssl version
OPENSSL_VERSION=1.0.2l

#ngx_pagespeed version
NPS_VERSION=1.12.34.2

#SYSTEM BITS
SYSTEM_BITS=64

#Directories
CURRENT_DIR=$(pwd)
OPENSSL_DIR=$(pwd)/openssl-${OPENSSL_VERSION}

#Save the nginx version
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
#Extracting nginx 
tar -xvf nginx-${NGINX_VERSION}.tar.gz
#Save the openssl version
wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
#Extracting openssl
tar -xvf openssl-${OPENSSL_VERSION}.tar.gz
#Save ngx_pagespeed module
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-beta.zip
#Extracting ngx_pagespeed module
unzip v${NPS_VERSION}-beta.zip
#Entering in ngx_pagespeed
cd ngx_pagespeed-${NPS_VERSION}-beta/
#Downloading psol
wget https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}-x64.tar.gz
#Extracting psol
tar -xzvf ${NPS_VERSION}-x${SYSTEM_BITS}.tar.gz 
# Exiting from ngx_pagespeed

#Entering inside the nginx folder
cd /root/nginx-${NGINX_VERSION}/
#Configuring 
./configure  \
--prefix=/etc/nginx \
--with-http_ssl_module \
--with-http_v2_module \
--with-openssl=${OPENSSL_DIR} \
--with-cc-opt="-Wno-deprecated-declarations" \
--add-module=${CURRENT_DIR}/ngx_pagespeed-${NPS_VERSION}-beta

# Compiling everything on 64 bits systems
KERNEL_BITS=${SYSTEM_BITS} make install

#Cleaning sources
cd ${CURRENT_DIR}
rm *.tar.gz
