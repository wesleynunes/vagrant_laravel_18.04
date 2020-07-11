#/usr/bin/env bash
echo "--- Instalando pacotes para desenvolvimento [PHP 7.2, LARAVEL]"

# Criar variaves para senha mysql e git
echo "--- definir senha, nome email git ---"
PASSWORD='123'
GITNAME="Wes"
GITEMAIL="wesleysilva.ti@gmail.com"

echo "--- update / upgrade ---"
sudo apt-get update
sudo apt-get -y upgrade

echo "--- instalando git ---"
sudo apt-get -y install git 
git config --global user.name ${GITNAME} 
git config --global user.email ${GITEMAIL}

echo "--- instalando curl wget zip unzip ---"
sudo apt-get -y install curl wget zip unzip

echo "--- instalar apache2---"
sudo apt-get -y install apache2
sudo ufw allow “Apache Full”
sudo systemctl status apache2

echo "--- instalar php7 e extensoes"
sudo apt-get -y install php libapache2-mod-php php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mbstring 
sudo apt-get -y install php-xml php-common php-cli php-intl php-bcmath php-imap php-soap php-tokenizer php-json php-sqlite  

echo "--- instalar mysql e fornercer senha para o instalador -- "
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get -y install php-mysql

echo "--- instalar mysql e fornecer senha para o instalador"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

echo "--- instalando nodejs ---"
sudo apt-get -y install nodejs
sudo apt-get -y install npm

echo "--- instalando redis-server ---"
sudo apt-get -y install redis-server

echo "--- habilitar mod-rewrite do apache ---"
sudo a2enmod rewrite

echo "--- reiniciar apache ---"
sudo service apache2 restart

echo "--- reiniciar mysql ---"
sudo service mysql restart

echo "-- instalar composer"
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer

#nova versao testar
# curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "--- reiniciar apache ---"
sudo service apache2 restart
    
echo "[OK] --- Ambiente de desenvolvimento concluido ---"