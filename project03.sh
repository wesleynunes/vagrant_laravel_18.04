#/usr/bin/env bash
echo "--- Criando projeto PHP"

# Criar variaves para senha mysql, nome do projeto, PHP e git
echo "--- Definir nome da pasta e nome do projeto PHP e a Url ---"
PROJECTFOLDER='project'
PROJECTNAME='php'
PROJECTURL='fullstack.com'
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

# echo "-- gerar projeto laravel"
# composer create-project --prefer-dist laravel/laravel /var/www/html/${PROJECTFOLDER}/${PROJECTNAME}

echo "-- gerar projeto php"
sudo mkdir "/var/www/html/${PROJECTFOLDER}/${PROJECTNAME}/public"

echo "-- permissao na pasta do projetos"
sudo chmod -R 777 /var/www/html/${PROJECTFOLDER}/

echo "--- reiniciar apache ---"
sudo service apache2 restart
    
echo "[OK] --- Projeto laravel criado!!!---"