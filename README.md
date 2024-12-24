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

### Creating the `.env.test` file

The `.env.test` file is created automatically when the package is installed. It contains the following information:

```sh
PHP_IMAGE=php:8.4-fpm-alpine
USER_ID=<id of the current user>
GROUP_ID=<id of the group of the current user>
```

The `USER_ID` and `GROUP_ID` are used to set the user and group of the current user in the Docker container.
This is done to avoid permission issues when running the tests and to create files or folders (if needed) with the correct permissions.