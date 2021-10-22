#!/bin/sh

GET_PWD="$(pwd)"
TOOLS_DIR="$GET_PWD/tools"

echo #espace row
read -p "> Création du Gitlab Secret ? (y/n)" execGitlabSecret

if [ "$execGitlabSecret" = "y" ]; then
  $TOOLS_DIR/create-gitlab-secret.sh
fi;

echo #espace row
read -p "> Lancer le helm install ? (y/n)" execHelmDeploy

if [ "$execHelmDeploy" = "y" ]; then
  echo #espace row
  echo "Le namespace name ? (défaut: app)"
  read namespace

  if [ -z "$namespace" ]; then
        namespace="app"
  fi;

  echo #espace row
  echo "Nom de la release ? (défaut: app)"
  read release

  if [ -z "$release" ]; then
        release="app"
  fi;

  helm install -n $namespace $release $GET_PWD/deploy
fi;

echo #espace row
echo #espace row
echo #espace row
echo #espace row
echo "** Le container mariadb doit être déjà créé et lancé pour la suite."
echo #espace row
echo #espace row
echo #espace row
echo #espace row
read -p "> Importation du dump dans mariadb ? (y/n)" execMariaDBDump

if [ "$execMariaDBDump" = "y" ]; then
  $TOOLS_DIR/import-dump-mariadb.sh
fi;

#read -p "> Mise à jour du fichier parameters.yml ? (y/n)" execUpdateParameters
#
#if [ "$execUpdateParameters" = "y" ]; then
#  $TOOLS_DIR/default-parameters.sh
#fi;

echo #espace row
read -p "> Lancer les migrations 'd:m:m' ? (y/n)" execDoctrineMM

if [ "$execDoctrineMM" = "y" ]; then
  $TOOLS_DIR/symfony-migration.sh
fi;

echo #espace row
read -p "> Clear le cache de symfony (prod) ? (y/n)" execClearCache

if [ "$execClearCache" = "y" ]; then
  $TOOLS_DIR/symfony-clear-cache.sh
fi;

exit 1
