# kktestappheroku

This is base application setup for Django projects.
Example application is avaliable on Heroku at URL: https://kktestappheroku.herokuapp.com/

## Setup application on Heroku

Before you run application on Heroku you will need to configure some additional parts.

1. Chose database which you want to use and add it to your project

    > [Django officially supports the following databases](https://docs.djangoproject.com/en/3.2/ref/databases/):
    > * PostgreSQL
    > * MariaDB
    > * MySQL
    > * Oracle

2. Configure environemnt variables on your Heroku project

    ```bash
    # enable debug logs (can be useful only for development environments)
    heroku config:set -a kktestappheroku DJANGO_DEBUG=TRUE

    # select database engine which you set up at first point
    heroku config:set -a kktestappheroku DATABASE_ENGINE=postgresql

    # generate your secret key and set it as environment variable
    heroku config:set -a kktestappheroku SECRET_KEY=your_example_secret_key
    ```

3. Create admin user to access admin panel

    ```bash
    heroku run python manage.py createsuperuser -a kktestappheroku
    ```

## Setup application on Docker

To build your own docker image use `docker build -t <docker_image_name> .`.

> The same as on Heroku configuration you must change `DJANGO_SECRET_KEY` which contains default not secure key.

You can run docker image by `docker run -p 8000 <docker_image_name>`

If you want also set up other envitonment variables as *DATABASE_ENGINE* or *DJANGO_DEBUG* you can set it also at run command by `--env-file` to set all wariables at one or separately `-e VAR=VALE`. Example env file for local development is [.env.dev](.env.dev) 


## Development

For development purposes the best solution is to use `docker-compose`.

```bash
# run docker-compose with build docker image form Dockerfile
docker-compose up -d --build

# execute migration
docker-compose exec web python manage.py migrate --noinput

# create admin user at Django portal
docker-compose exec web python manage.py createsuperuser

# turn off Docker containers
docker-compose down
```

> If you want to destroy database or you changed database setting as user, pasword or name you need to delete `docker volume`
> `docker volume rm simpleapp_postgres_data`
