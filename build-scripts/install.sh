#!/bin/bash
echo "Core Install"
wp core install --allow-root --path=`/var/www/html` --url=localhost:3080 --title='TIWS Dev Site' --admin_user=admin --admin_password=admin --admin_email=info@traderinteractive.tech
echo "CWS SDK Install"
wp plugin install --activate --path=`/var/www/html` --allow-root ws-wp-plugin-cws-sdk 
echo "Remove Akismet and Hello Dolly"
wp plugin delete --allow-root --path=`/var/www/html` akismet
wp plugin delete --allow-root --path=`/var/www/html` hello
echo "Plugin Install"
for p in $(wp plugin --allow-root --path=`/var/www/html` --field=name list); do
    echo "... $p"
    wp plugin install --allow-root --path=`/var/www/html` --activate $p 
done; 
echo "Set Options"
wp option update cws_dealer_id 23 --path=`/var/www/html` --allow-root
wp user set-role admin system-admin --path=`/var/www/html` --allow-root