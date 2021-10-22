#!/bin/sh

echo "Nom du namespace ? (défaut: app)"
read namespace

if [ -z "$namespace" ]
then
      namespace="app"
fi

echo #espace row
echo "Nom du service mariadb ? (défaut: app-mariadb)"
read dbSvcName

if [ -z "$dbSvcName" ]
then
      dbSvcName="app-mariadb"
fi

echo #espace row
echo "Nom de la base de données ? (défaut: databaseName)"
read dbName

if [ -z "$dbName" ]
then
      dbName="databaseName"
fi

echo #espace row
echo "Port de la base de données ? (défaut: 3306)"
read dbPort

if [ -z "$dbPort" ]
then
      dbPort="3306"
fi

echo #espace row
echo "Mot de passe root mariadb ? (défaut: password)"
read dbRootPassword

if [ -z "$dbRootPassword" ]
then
      dbRootPassword="password"
fi

echo #espace row
echo "Nom du pod Symfony ?"
read backendPod

kubectl -n $namespace cp $backendPod:/code/app/config/parameters.yml /tmp/_appKube/parameters.yml

# Here is for Symfony 3.4 APP
# Mise à jour du host
echo #espace row
echo "Mise à jour du host"
yq w /tmp/_appKube/parameters.yml "parameters.database_host" "${dbSvcName}" > /tmp/_appKube/parameters_w.yml

cp /tmp/_appKube/parameters_w.yml /tmp/_appKube/parameters_ww.yml

# Mise à jour du port
echo #espace row
echo "Mise à jour du port"
yq w /tmp/_appKube/parameters_ww.yml "parameters.database_port" "${dbPort}" > /tmp/_appKube/parameters_w.yml

cp /tmp/_appKube/parameters_w.yml /tmp/_appKube/parameters_ww.yml

# Mise à jour du nom de la database
echo #espace row
echo "Mise à jour du nom de la database"
yq w /tmp/_appKube/parameters_ww.yml "parameters.database_name" "${dbName}" > /tmp/_appKube/parameters_w.yml

cp /tmp/_appKube/parameters_w.yml /tmp/_appKube/parameters_ww.yml

# Mise à jour du mot de passe
echo #espace row
echo "Mise à jour du mot de passe"
yq w /tmp/_appKube/parameters_ww.yml "parameters.database_password" "${dbRootPassword}" > /tmp/_appKube/parameters_w.yml

echo #espace row
cat /tmp/_appKube/parameters_w.yml
read -p "Continuer ? (y/n)" FINISH_WORK

if [ "$FINISH_WORK" = "y" ]; then
	echo "Envoi du fichier dans le pod"
	kubectl -n $namespace cp /tmp/_appKube/parameters_w.yml $backendPod:/code/app/config/parameters.yml
fi;

echo #espace row
echo "Suppression de l'environnement de travail temporaire. (/tmp/_appKube)"
rm -r -f -i /tmp/_appKube/ --interactive

echo #espace row
echo "Travail terminé!"
