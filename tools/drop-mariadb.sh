#!/bin/sh

GET_PWD="$(pwd)"
TOOLS_DIR="$GET_PWD/tools"

echo #espace row
echo "Nom du namespace ? (défaut: app)"
read namespace

if [ -z "$namespace" ]
then
      namespace="app"
fi

echo #espace row
echo "Nom du pod MariaDB ?"
read databasePod

echo #espace row
echo "Nom d'utilisateur mariadb  ? (défaut: root)"
read dbUser
if [ -z "$dbUser" ]
then
      dbUser="root"
fi

echo #espace row
echo "Nom de la base de données ? (défaut: databaseName)"
read dbName

if [ -z "$dbName" ]
then
      dbName="databaseName"
fi

echo #espace row
echo "Mot de passe root mariadb ? (défaut: password)"
read dbRootPassword

if [ -z "$dbRootPassword" ]
then
      dbRootPassword="password"
fi

echo #espace row
echo "kubectl -n $namespace exec -i $databasePod -- mysql -u $dbUser -p$dbRootPassword -D $dbName -e "DROP DATABASE $dbName""
read -p "Je vais exécuter la commande ci-dessus, c'est bon pour vous ? (y/n)" execCommand

if [ "$execCommand" = "y" ]; then
  kubectl -n $namespace exec -i $databasePod -- mysql -u $dbUser -p$dbRootPassword -D $dbName -e "DROP DATABASE $dbName"
fi;

echo #espace row
echo "Voici les bases de données restantes : "
echo #espace row
kubectl -n $namespace exec -i $databasePod -- mysql -u $dbUser -p$dbRootPassword -e "show databases;"
