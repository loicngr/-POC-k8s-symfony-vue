#!/bin/sh

echo "Le namespace name ? (défaut: app)"
read namespace

if [ -z "$namespace" ]
then
      namespace="app"
fi

echo "Username gitlab ? "
read username

echo "Token gitlab ? "
read token

echo "Email gitlab ? "
read email

echo "Nom du secret ? (défaut: gitlab-registry)"
read secretName

if [ -z "$secretName" ]
then
      secretName="gitlab-registry"
fi

kubectl -n $namespace create secret docker-registry $secretName \
 --docker-server="registry.gitlab.com" --docker-username="$username" --docker-password="$token" \
  --docker-email="$email" -o yaml --dry-run=client | kubectl apply -f -

echo "Secret $secretName bien créé dans le namespace $namespace."
