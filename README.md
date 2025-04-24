
# MulerTech Docker-tests

___
[![Latest Version on Packagist](https://img.shields.io/packagist/v/mulertech/docker-tests.svg?style=flat-square)](https://packagist.org/packages/mulertech/docker-tests)
[![Total Downloads](https://img.shields.io/packagist/dt/mulertech/docker-tests.svg?style=flat-square)](https://packagist.org/packages/mulertech/docker-tests)
___


The **MulerTech Docker-tests** package allows you to configure and run PHP tests in a Docker environment.

## Description

This package configures a Docker container to run PHP tests using PHPUnit. It creates a .env.test file with the necessary information to build the Docker image and run the tests.

## Prerequisites

- Docker
- PHP
- Composer

## Installation

1. Include the package as a dev dependency with Composer :

    ```sh
    composer require-dev mulertech/docker-tests
    ```

2. Run the following command to install the package :

    ```sh
    composer install
    ```

## Usage

### Running the tests

To run the tests, use the following command:

```sh
./vendor/bin/mtdocker test
```

To run the tests with code coverage, use the following command:

```sh
./vendor/bin/mtdocker test-coverage
```
The code coverage report will be generated in the `./.phpunit.cache/coverage` folder.

These commands will:
- Check if the Docker container is running.
- If the container is not running, it will be started.
- Run the PHPUnit tests in the container.
- Stop the container if it was not running before the tests were executed.

### Running phpstan

To run phpstan, use the following command:

```sh
./vendor/bin/mtdocker phpstan
```

This command will:
- Check if the Docker container is running.
- If the container is not running, it will be started.
- Run phpstan in the container.
- Stop the container if it was not running before phpstan was executed.

### Running php-cs-fixer

To run php-cs-fixer, use the following command:

```sh
./vendor/bin/mtdocker php-cs-fixer
```

This command will:
- Check if the Docker container is running.
- If the container is not running, it will be started.
- Run php-cs-fixer in the container.
- Stop the container if it was not running before php-cs-fixer was executed.

### Running php-cs-fixer, phpunit and phpstan

To run php-cs-fixer, phpunit and phpstan, use the following command:

```sh
./vendor/bin/mtdocker all
```

This command will:
- Check if the Docker container is running.
- If the container is not running, it will be started.
- Run php-cs-fixer, phpunit and phpstan in the container.
- Stop the container if it was not running before the checks were executed.

### Starting the Docker container

To start the Docker container, use the following command :

```sh
./vendor/bin/mtdocker up
```

To start the Docker container in detached mode, use the following command :

```sh
./vendor/bin/mtdocker up -d
```

### Stopping the Docker container

To stop the Docker container, use the following command :

```sh
./vendor/bin/mtdocker down
```

### Checking the status of containers

To check the status of the Docker containers, use the following command:

```sh
./vendor/bin/mtdocker ps
```

This command will display all containers related to the project and their current status.

### Getting the project name

To get the project name used for Docker Compose (useful for PHPStorm configuration), use the following command:

```sh
./vendor/bin/mtdocker name
```

This command will output the project name that should be used in the `COMPOSE_PROJECT_NAME` environment variable when configuring PHPStorm. (see below)

### Configuring the Docker container into PHPStorm

To configure the Docker container into PHPStorm, follow these steps:

1. Open the PHPStorm settings.
2. Go to `PHP`.
3. Click on the `...` button next to the `CLI Interpreter` field.
4. Click on the `+` button and select `From Docker, Vagrant, VM, WSL, Remote...`.
5. Configure the remote PHP interpreter as follows:
    - Select `Docker Compose`.
    - Set the server to `Docker` or click on `New...` if this server does not exist and :
        - Set the name to `Docker`.
        - Select `Docker for Windows` or `Unix socket` depending on your system.
        - Click on `OK`.
    - Set the configuration files to `./mt-compose.yml`.
    - Set the service to `php`.
    - Set the Environment variables to `COMPOSE_PROJECT_NAME=<project name>` the project name is given by the "./vendor/bin/mtdocker name" command line argument. (see above)
    - Click on `OK`.
6. Click on `OK` to save the configuration.

To configure PHPUnit, follow these steps:

1. Go to `PHP` > `Test Frameworks`.
2. Click on the `+` button and select `PHPUnit by Remote Interpreter`.
3. Set the interpreter to `php` and click on `OK`.
4. Set the path to script to `/var/www/html/vendor/autoload.php`.
5. Click on `OK` to save the configuration.

### Creating the `mt-compose.yml` file

The `mt-compose.yml` file is created automatically when the container starts. It contains the following information :

```sh
services:
  php:
    build:
      context: .
      dockerfile: "./vendor/mulertech/docker-tests/Dockerfile"
      args:
        USER_ID: $uid
        GROUP_ID: $gid
        PHP_IMAGE: "$image"
    container_name: "$containerName"
    volumes:
      - "./:/var/www/html"
    environment:
      PHP_CS_FIXER_IGNORE_ENV: 1
```

The `USER_ID` and `GROUP_ID` are used to set the user and group of the current user in the Docker container.
This is done to avoid permission issues when running the tests and to create files or folders (if needed) with the correct permissions.
The `PHP_IMAGE` is `php:<php version>-fpm-alpine`, the php version is set from the required version in the `composer.json` file.
The `container_name` is set to `mt-docker-<package name>-<php version>`.

### Adding the database to mt-compose.yml

If your project requires a database (the composer.json file contains ext-pdo),
the mt-compose.yml file will be automatically updated to include a database service. Here is an example configuration for MySQL:

```sh
services:
  php:
    build:
      context: .
      dockerfile: "./vendor/mulertech/docker-tests/Dockerfile"
      args:
        USER_ID: $uid
        GROUP_ID: $gid
        PHP_IMAGE: "$image"
    container_name: "$containerName"
    volumes:
      - "./:/var/www/html"
    environment:
      PHP_CS_FIXER_IGNORE_ENV: 1
      DATABASE_HOST: db
      DATABASE_PORT: "3306"
      DATABASE_PATH: "/db"
      DATABASE_SCHEME: "mysql"
      DATABASE_QUERY: "serverVersion=5.7"
      DATABASE_USER: "user"
      DATABASE_PASS: "password"
    links:
      - db
    networks:
      - default
  db:
    image: "mysql:8"
    environment:
      MYSQL_DATABASE: db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_ROOT_PASSWORD: root
    ports:
      - "$dbPort:3306"
    networks:
      - default
```

This configuration adds a db service using the mysql:8 image and sets the necessary environment variables to connect to the database from the PHP container.
The database is also exposed on a unique port on your host machine, derived from the container name.
This ensures that different projects can run simultaneously without port conflicts.
The port is deterministically generated based on the container name and will be consistent for the same project.