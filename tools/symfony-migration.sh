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

kubectl -n $namespace exec -i $backendPod -- php /code/bin/console doctrine:migrations:migrate