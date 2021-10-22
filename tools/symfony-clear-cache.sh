#!/bin/sh

GET_PWD="$(pwd)"

echo #espace row
echo "Nom du namespace ? (défaut: app)"
read namespace

if [ -z "$namespace" ]
then
      namespace="app"
fi

echo #espace row
echo "Nom du pod Symfony ?"
read backendPod

echo #espace row
echo "kubectl -n $namespace exec -i $backendPod -- rm -r /code/var/cache"
read -p "Supprimer le dossier /code/var/cache ? (y/n)" execDeleteCache

if [ "$execDeleteCache" = "y" ]; then
  kubectl -n $namespace exec -i $backendPod -- rm -rf /code/var/cache
#  kubectl -n $namespace exec -i $backendPod -- mkdir /code/var/cache && chown -Rf www-data:www-data /code/var
else
  kubectl -n $namespace exec -i $backendPod -- php /code/bin/console cache:clear --env=prod
fi;
