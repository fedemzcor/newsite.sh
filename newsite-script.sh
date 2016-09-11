#! /bin/bash
clear && read -p "Hola, ¿Cual es el nombre de usuario que deseas crear? " user_name && 
adduser $user_name && 
usermod -aG sudo $user_name &&
usermod -aG www-data $user_name &&
mkdir /home/$user_name/public_html && 
chown -R $user_name:www-data /home/$user_name &&
chmod -R 770 /home/$user_name &&
chmod -R g+s /home/$user_name &&  
usermod -d /home/$user_name/public_html $user_name && 
read -p "Ingresa el dominio del sitio [example.com] " domain_name && echo "<VirtualHost *:80>" >>
/etc/apache2/sites-available/$domain_name.conf && echo "ServerName $domain_name" >>
/etc/apache2/sites-available/$domain_name.conf && echo "ServerAdmin $user_name@$domain_name" >>
/etc/apache2/sites-available/$domain_name.conf && echo "DocumentRoot /home/$user_name/public_html" >>
/etc/apache2/sites-available/$domain_name.conf && echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >>
/etc/apache2/sites-available/$domain_name.conf && echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >>
/etc/apache2/sites-available/$domain_name.conf && echo "</VirtualHost>" >> /etc/apache2/sites-available/$domain_name.conf &&
a2ensite $domain_name && service apache2 reload && echo "Usuario $user_name se ha creado correctamente."