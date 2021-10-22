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

echo #espace row
echo "prod ou dev ? (prod/dev)"
read logType

kubectl -n $namespace exec -i $backendPod -- tail -f /code/var/logs/$logType.log | awk '
/(request|app)\.INFO/ {print "\033[36m" $0 "\033[39m"}
/(request|app)\.WARNING/ {print "\033[33m" $0 "\033[39m"}
/(request|app)\.ERROR/ {print "\033[31m" $0 "\033[39m"}
/(request|app)\.CRITICAL/ {print "\033[31m" $0 "\033[39m"}
'
