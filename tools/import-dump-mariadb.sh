#!/bin/sh
# Importation du dump dans la base de données du pod mariadb

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
echo "kubectl -n $namespace exec -i $databasePod -- mysql -u $dbUser -p$dbRootPassword $dbName < $TOOLS_DIR/dump.sql"
read -p "Je vais exécuter la commande ci-dessus, c'est bon pour vous ? (y/n)" execCommand

if [ "$execCommand" = "y" ]; then
  kubectl -n $namespace exec -i $databasePod -- mysql -u $dbUser -p$dbRootPassword $dbName < $TOOLS_DIR/dump.sql
fi;