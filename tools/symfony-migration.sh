#!/bin/sh

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

kubectl -n $namespace exec -i $backendPod -- php /code/bin/console doctrine:migrations:migrate
