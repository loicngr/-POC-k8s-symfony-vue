# Setup
- Configuration
    - Création du fichier **_parameters.yml_** dans _**/deploy/charts/back/config/**_
        - Y renseigner les variables qui seront merge avec le fichier généré lors du "composer install"
        
# Mise en ligne
- ```shell
  $ kubectl create namespace app  
  ```
- ```shell
  $ ./tools/init.sh
  ```

# Commandes de base

## Lancer minikube
- ``minikube start``
## Créer le Gitlab secret
- ``kubectl create secret docker-registry gitlab-registry --docker-server="registry.gitlab.com" --docker-username="username" --docker-password="password" --docker-email="email" -o yaml --dry-run=client | kubectl apply -f -``
## Installer un chart
- ``helm install [NAME] ./deploy``
## Mise à jour d'un chart
- ``helm upgrade [NAME] ./deploy``
## Désinstaller un chart
- ``helm uninstall [NAME] ./deploy``
## Lancer le service minikube
- ``minikube service [NAME]``
## Fermer minikube
- ``minikube stop``
