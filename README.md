# MulerTech Docker-tests

Le package **MulerTech Docker-tests** permet de configurer et d'exécuter des tests PHP dans un environnement Docker.

## Description

Ce package configure un conteneur Docker pour exécuter des tests PHP en utilisant PHPUnit. Il crée un fichier `.env.test` avec les informations nécessaires pour construire l'image Docker et exécuter les tests.

## Prérequis

- Docker
- PHP
- Composer

## Installation

1. Clonez le dépôt du projet.
2. Installez les dépendances avec Composer :

    ```sh
    composer install
    ```

## Utilisation

### Lancer les tests

Pour lancer les tests, utilisez la commande suivante :

```sh
./vendor/bin/mtdocker test
```

Cette commande va :
- Vérifier si le conteneur Docker mt-docker-tests est en cours d'exécution.
- Si le conteneur n'est pas en cours d'exécution, il sera démarré.
- Exécuter les tests PHPUnit dans le conteneur.
- Arrêter le conteneur si il n'était pas en cours d'exécution avant l'exécution des tests.

### Démarrer le conteneur docker

Pour démarrer le conteneur Docker, utilisez la commande suivante :

```sh
./vendor/bin/mtdocker up
```

Pour démarrer le conteneur Docker en mode détaché, utilisez la commande suivante :

```sh
./vendor/bin/mtdocker up -d
```

### Arrêter le conteneur docker

Pour arrêter le conteneur Docker, utilisez la commande suivante :

```sh
./vendor/bin/mtdocker down
```

### Création du fichier `.env.test`

Le fichier `.env.test` est automatiquement créé à la racine du projet si il n'existe pas lors de l'exécution des commandes suivantes.

