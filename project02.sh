#/usr/bin/env bash
echo "--- Criando projeto laravel escolhendo versao"

# Criar variaves para senha mysql, nome do projeto, projeto laravel e git
echo "--- Definir nome da pasta e nome do projeto laravel ---"
PROJECTFOLDER='project'
PROJECTNAME="web"
PROJECTURL='laradev.com'
SERVERADMIN="wesleysilva.ti@gmail.com"

echo "--- criar pasta do projeto ---"
sudo mkdir "/var/www/html/${PROJECTFOLDER}"

echo "--- arquivo host ---"
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin ${SERVERADMIN}
    ServerName  ${PROJECTNAME}.${PROJECTURL}
    ServerAlias ${PROJECTNAME}.${PROJECTURL}
    DocumentRoot "/var/www/html/${PROJECTFOLDER}/${PROJECTNAME}/public"
    <Directory "/var/www/html/${PROJECTFOLDER}/${PROJECTNAME}/public">
        AllowOverride All
        Require all granted
    </Directory>    
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/${PROJECTNAME}.conf

echo "--- habilitar mod-rewrite do apache ---"
sudo a2ensite ${PROJECTNAME}.conf
sudo a2enmod rewrite

echo "--- reiniciar apache ---"
sudo service apache2 restart

echo "--- reiniciar mysql ---"
sudo service mysql restart

echo "-- gerar projeto laravel"
composer create-project --prefer-dist laravel/laravel /var/www/html/${PROJECTFOLDER}/${PROJECTNAME} "5.7.*" #gera a versao do laravel
# composer create-project --prefer-dist laravel/laravel /var/www/html/${PROJECTFOLDER}/${PROJECTNAME}
sudo chmod -R 777 /var/www/html/${PROJECTFOLDER}/

echo "--- reiniciar apache ---"
sudo service apache2 restart
    
echo "[OK] --- Projeto laravel criado!!! ---"