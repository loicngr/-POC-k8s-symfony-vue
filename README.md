## Pré-requis (dev)
- `make kube-start` pour lancer minikube

## Configuration
- Création du fichier `parameters.yml` (reprendre celui généré par symfony) dans `deploy/charts/back/config`
  - Pour la connexion à la base de données, il faut utiliser le nom du service k8s (exemple : `database_host: app-mariadb`)
  - Pour les autres informations, reprendre celles utilisées dans `deploy/values.yaml`

## Initialisation
- `make init` (création namespace + execution de `tools/init.sh`)

## Helm
- `make helm-install` pour installer les charts
- `make helm-uninstall` pour désinstaller les charts
- `make helm-upgrade` pour mettre à jour les charts

## MEP (local)
- [`make kube-tunnel`](https://minikube.sigs.k8s.io/docs/commands/tunnel)
- Front : `http://front.127.0.0.1.nip.io`
- Back : `http://api.127.0.0.1.nip.io`

## Liens
- https://kubernetes.io/fr/docs/tutorials/hello-minikube/
- https://helm.sh/docs/chart_template_guide/getting_started/
- https://kubernetes.io/docs/reference/kubectl/conventions/
- https://kubectl.docs.kubernetes.io/guides/container_debugging/copying_container_files/
