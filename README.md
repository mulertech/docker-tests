
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
      COMPOSE_BAKE: true
```

The `USER_ID` and `GROUP_ID` are used to set the user and group of the current user in the Docker container.
This is done to avoid permission issues when running the tests and to create files or folders (if needed) with the correct permissions.
The `PHP_IMAGE` is `php:<php version>-fpm-alpine`, the php version is set from the required version in the `composer.json` file.
The `container_name` is set to `mt-docker-<package name>-<php version>`.
