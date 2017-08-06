#!/bin/sh

chmod -R 777 /var/www/runtime
chmod -R 777 /var/www/web
chmod -R 755 /var/www/yii

cd /var/www && /usr/bin/composer install

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf