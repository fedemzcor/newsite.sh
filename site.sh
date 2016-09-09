#! /bin/bash
clear && read -p "¿Cual es el nombre de usuario que deseas crear? " user_name && 
adduser $user_name && 
adduser $user_name sudo && 
mkdir /home/$user_name/public_html && 
chown $user_name:$user_name /home/$user_name && 
chmod 750 /home/$user_name &&
chmod 755 /home/$user_name/public_html && 
usermod -d /home/$user_name/public_html $user_name && 
read -p "Ingresa el dominio del sitio [example.com] " domain_name && 
echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/$domain_name.conf && 
echo "ServerName $domain_name" >> /etc/apache2/sites-available/$domain_name.conf && 
echo "ServerAdmin $user_name@$domain_name" >> /etc/apache2/sites-available/$domain_name.conf && 
echo "DocumentRoot /home/$user_name/public_html" >> /etc/apache2/sites-available/$domain_name.conf 
&& echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/$domain_name.conf && 
echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/$domain_name.conf && 
echo "</VirtualHost>" >> /etc/apache2/sites-available/$domain_name.conf && 
a2ensite $domain_name && 
service apache2 reload && 
echo "El usuario $user_name se ha creado correctamente"
