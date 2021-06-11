#!/bin/sh

echo "Récupération du fichier 'parameters.yml'"
echo "Le namespace name ? "
read namespace

echo "Le pod symfony ?"
read pod

echo "Le pod mariadb name ?"
read pod_secret

kubectl -n $namespace cp $pod:/code/app/config/parameters.yml /tmp/_appKube/parameters.yml

echo "Récupération du mod de passe"
password=$(kubectl get secret -n $namespace $pod_secret -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)

echo "Modification du fichier"
yq w /tmp/_appKube/parameters.yml "parameters.database_password" "${password}" > /tmp/_appKube/parameters_w.yml

echo "Le fichier modifié et conforme ?"

cat /tmp/_appKube/parameters_w.yml
read -p "Continuer ? (y/n)" FINISH_WORK

if [ "$FINISH_WORK" = "y" ]; then
	echo "Envoi du fichier dans le pod"
	kubectl -n $namespace cp /tmp/_appKube/parameters_w.yml $pod:/code/app/config/parameters.yml

	echo "Travail terminé!"
else
	echo "Arret du programme."
fi;

