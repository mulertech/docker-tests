# MulerTech Docker-tests

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

This command will:  
- Check if the Docker container `mt-docker-tests` is running.
- If the container is not running, it will be started.
- Run the PHPUnit tests in the container.
- Stop the container if it was not running before the tests were executed.

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
    - Set the configuration files to `./vendor/mulertech/docker-tests/compose.yml`.
    - Set the service to `php`.
    - Click on `OK`.
6. Select `Connect to existing container ('docker-compose exec')` in the `Lifecycle` section.
7. Click on `OK` to save the configuration.

To configure PHPUnit, follow these steps:

1. Go to `PHP` > `Test Frameworks`.
2. Click on the `+` button and select `PHPUnit by Remote Interpreter`.
3. Set the interpreter to `php` and click on `OK`.
4. Set the path to script to `/var/www/html/vendor/autoload.php`.
5. Click on `OK` to save the configuration.

### Creating the `.env.test` file

The `.env.test` file is created automatically when the container starts. It contains the following information :

```sh
PHP_IMAGE=php:8.4-fpm-alpine
USER_ID=<id of the current user>
GROUP_ID=<id of the group of the current user>
CONTAINER_NAME=mt-docker-8.4
```

The `USER_ID` and `GROUP_ID` are used to set the user and group of the current user in the Docker container.
The php version is set from the required version in the `composer.json` file.
This is done to avoid permission issues when running the tests and to create files or folders (if needed) with the correct permissions.