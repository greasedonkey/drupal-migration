# Drupal 8 CI with Composer and Docker

## Introduction

The goals of this project are to:

1. Maintain an up-to-date installation of Drupal 8 by using Composer to manage dependencies and Docker to containerize the application.
1. Provide an environment for developers to code and effectively test their contribution. (Including tools to support the development and testing of the application)
1. Set-up a base pipeline, to build and test the application.

### Composer template from Drupal projects.

This project was created using the "[Composer template for Drupal projects](https://github.com/drupal-composer/drupal-project)" as per the official documentation found on the official drupal.org website, "[Using Composer to Install Drupal and Manage Dependencies](https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies)".

Getting familiar with this project is essential for contributing to this project.  Please refer to the README.md file of this project to see what it can do; for example, how to update Drupal Core file or how to add dependencies, etc.

### Docker

While [Docker](https://docs.docker.com/) is technically not required to spin-up this project it take most of the heavy lifting required to spin up an environment to run the application. Docker provide an environment for developers to contribute and test their code in a controlled environment that contains all the libraries and dependencies required to run this project.

Understanding Docker is crutial to effectively contribute to this project.

#### Drupal Docker Official Images

The Dockerfile of this project is based from the official fpm images found on docker hub (https://hub.docker.com/_/drupal/). A lot of work was done in theses official images to provide a stable environment to run a Drupal 8 application.  We leverage the bulk of it, but we maintain the Drupal 8 files using composer.

## Usage

The lastest version of [Docker CE](https://docs.docker.com/install/) is the only software required to run this project.

### docker-compose

This project includes a base docker-compose file to spin-off a Drupal 8 stack that is composed of three services (Nginx, Drupal/PHP, MySQL).

Here are a few useful commands to get you started with a brief description on what they do.  Please refer to the official docker and docker-compose documentation for more information.

```bash
# Start containers based on the docker-compose.yml configuration
docker-compose up -d

# Same as above, and build the DockerFile
docker-compose up -d --build

# Bring down the containers
docker-compose down

# Same as above, and remove volumes (database)
docker-compose down -v
```

## Development

### Coding

Any files or folders that are not specified in the `.dockerignore` file will be pushed to the container at build time.  When working on custom code or if you need to update the composer.json/lock files, for examples, it is easier and faster to mount the files and folders needed using docker-compose rather then re-building the docker image.

For example, adding the following lines to the volumes section of the `drupal` service in the `docker-compose.yml` file, will bind mounts these files from the host to inside the container. This will allow you to modify the files either directly from the container or the host.

```yaml
- ./composer.json:/app/composer.json
- ./composer.lock:/app/composer.lock
```

Learn more about docker volumes [docker volumes](https://docs.docker.com/storage/volumes/) from the official documentation.

### Testing

#### Building a test image

```bash
docker build -t drupal8-ci .
docker build -t drupal8-ci-sut -f Dockerfile-test .
```
#### Code Review

The [Coder project](https://www.drupal.org/project/coder) bundled in this project contains two "sniffs" for PHP CodeSniffer. Please refer to the documentation of the project to learn more about the differences between each "sniffs".

```bash
# Testing code with DrupalPratice
docker run --rm drupal8-ci-sut phpcs --standard=DrupalPractice /path/to/file.php /path/to/dir

# Testing code with Drupal
docker run --rm drupal8-ci-sut phpcs --standard=DrupalPractice /path/to/file.php /path/to/dir
```