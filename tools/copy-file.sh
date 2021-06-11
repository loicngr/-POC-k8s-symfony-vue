#!/bin/sh

GET_PWD="$(pwd)"
TOOLS_DIR="$GET_PWD/tools"

echo "Nom du namespace ? (défaut: default)"
read namespace

if [ -z "$namespace" ]
then
      namespace="default"
fi

echo "Nom du pod cible ?"
read toPod

echo "Nom du fichier en local à copier vers le pod ? (ex: $GET_PWD/tools/dump.sql)"
read fileName

echo "Nom du dossier dans le pod pour coller le fichier ? (ex: /tmp)"
read toPodDir

echo #espace row
echo "kubectl -n $namespace cp $fileName $toPod:$toPodDir"
read -p "Je vais exécuter la commande ci-dessus, c'est bon pour vous ? (y/n)" execCommand

if [ "$execCommand" = "y" ]; then
  kubectl -n $namespace cp $fileName $toPod:$toPodDir
  echo "Fichier copié dans le pod à l'emplacement : '$toPodDir'"
fi;