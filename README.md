![Docker Pulls](https://img.shields.io/docker/pulls/mdsami/laravel.svg)

# laravel
Docker image to run PHP (supporting Laravel), MongoDB , Ngnix and Node projects.

This image it's for development. **Optimize to use in production!**

In the latest update, I changed the base image to `php:alpine` for size optimizing.

## Tags
* [**`latest`**:](https://github.com/mdsami/laravel/blob/master/Dockerfile)  
 * `php` 7.2.5
   * `composer` 1.6.4
 * `nodejs` 10.0.0
   * `npm` 6.0.0
   * `yarn` 1.6.0

## Supported Databases (**PDO**)
* `mssql` (via dblib)
* `mysql`
* `pgsql`
* `sqlite`


## Extra supported extensions
* `curl`
* `exif`
* `gd`
* `ldap`
* `mongodb`

## Installing
    docker pull mdsami/laravel

## Using

### With `docker`
    docker run --name <container_name> -d -v $PWD:/var/www -p 80:80 mdsami/laravel
Where $PWD is the laravel installation folder.

### With `docker-compose`

Create a `docker-compose.yml` file in the root folder of project using this as a template:
```
web:
    image: mdsami/laravel:latest
    ports:
        - 80:80
    volumes:
        - ./:/var/www
    # If you don't want to use default 'artisan serve' command, edit and uncomment the line below.
    # command: php -S 0.0.0.0:80 -t public public/index.php
```

Then run using this command:

    docker-compose up