
Docker Template for Laravel

#####Using PHP 8, PHP-FPM, Nginx and PCOV for testing

Server, runs as non root user for enhanced security.

If your new to docker, you can watch my courses at https://www.youtube.com/channel/UCrw3F3hnsOGRXFJXHo_Ri6w

To use, clone this repo inside your Laravel project.
Inside your .env file, add the following values for your database
````
DB_CONNECTION=mysql
DB_HOST=database_mysql
DB_PORT=3306
DB_DATABASE=default
DB_USERNAME=laravel
DB_PASSWORD=secret
````
Or adjust the docker-compose.yml accordingly.

I also added an optional Makefile that contains commands to build and start containers. See Makefile or in your terminal write `make` to see list of commands. If you adjusted the container name inside the `docker-compose.yml` make sure to adjust the `CONTAINER_PHP=api` inside the Makefile.
