#!/bin/sh
# Création d'un dump mysql

GET_PWD="$(pwd)"
TOOLS_DIR="$GET_PWD/tools"

echo "Nom du namespace ? (défaut: default)"
read namespace

if [ -z "$namespace" ]
then
      namespace="default"
fi

echo "Nom du pod MariaDB ?"
read databasePod

echo "Nom d'utilisateur mariadb  ? (défaut: root)"
read dbUser
if [ -z "$dbUser" ]
then
      dbUser="root"
fi

echo "Nom de la base de données ? (défaut: default)"
read dbName

if [ -z "$dbName" ]
then
      dbName="databaseName"
fi

echo "Mot de passe root mariadb ? (défaut: password)"
read dbRootPassword

if [ -z "$dbRootPassword" ]
then
      dbRootPassword="password"
fi

echo #espace row
echo "kubectl -n $namespace exec -i $databasePod -- mysqldump -u $dbUser -p$dbRootPassword $dbName > $TOOLS_DIR/new_dump.sql"
read -p "Je vais exécuter la commande ci-dessus, c'est bon pour vous ? (y/n)" execCommand

if [ "$execCommand" = "y" ]; then
  kubectl -n $namespace exec -i $databasePod -- mysqldump -u $dbUser -p$dbRootPassword $dbName > $TOOLS_DIR/new_dump.sql
fi;