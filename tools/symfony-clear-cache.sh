#!/bin/sh

echo #espace row
echo "Nom du namespace ? (défaut: default)"
read namespace

if [ -z "$namespace" ]
then
      namespace="default"
fi

echo #espace row
echo "Nom du pod Symfony ?"
read backendPod

echo #espace row
echo "kubectl -n $namespace exec -i $backendPod -- rm -r /code/var/cache"
read -p "Supprimer le dossier /code/var/cache ? (y/n)" execDeleteCache

if [ "$execDeleteCache" = "y" ]; then
  kubectl -n $namespace exec -i $backendPod -- rm -rfI /code/var/cache --interactive=once
fi;

kubectl -n $namespace exec -i $backendPod -- php /code/bin/console cache:clear --env=prod