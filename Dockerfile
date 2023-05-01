FROM alpine:3.12
MAINTAINER kensium
RUN apk update && apk add nginx git && mkdir -p /run/nginx && apk add php7 php7-fpm php7-bcmath php7-cli php7-ctype php7-curl php7-dom php7-fpm php7-gd php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-openssl php7-pdo_mysql php7-phar php7-session php7-simplexml php7-soap php7-tokenizer php7-xml php7-xmlwriter php7-xsl php7-zip php7-zlib php7-sockets php7-sodium php7-fileinfo 
RUN apk add mysql mysql-client && addgroup mysql mysql
RUN apk add curl wget  vim sudo bash net-tools openjdk11 && rm -rf /var/cache/apk/* && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-linux-x86_64.tar.gz && tar -xvzf elasticsearch-7.6.2-linux-x86_64.tar.gz -C /usr/share/ && echo -e "export ES_JAVA_HOME=/usr/lib/jvm/java-11-openjdk\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk" >> /etc/profile && mv /usr/share/elasticsearch-7.6* /usr/share/elasticsearch && mkdir /usr/share/elasticsearch/data && mkdir /usr/share/elasticsearch/config/scripts && adduser -D -u 1000 -h /usr/share/elasticsearch elasticsearch && chown -R elasticsearch /usr/share/elasticsearch && rm -rf /usr/share/elasticsearch/modules/x-pack-ml && rm -rf /var/cache/apk/* /elasticsearch-7.6.2-linux-x86_64.tar.gz && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&  php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && php composer-setup.php && mv composer.phar /usr/local/bin/composer

COPY php /etc/php7/php.ini
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY default1 /etc/nginx/conf.d/default.conf
COPY elasticsearch /usr/share/elasticsearch/config
COPY auth.json /root/.composer/auth.json
COPY composer.json /var/www/html/magento/composer.json
COPY mysql.sh /
RUN chmod +x ./mysql.sh
ENTRYPOINT ["/mysql.sh"]
