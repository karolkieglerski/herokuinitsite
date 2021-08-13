FROM python:3.9.6-alpine3.14

# non production secret key
ENV DJANGO_SECRET_KEY='django-insecure-21tn#_&adifj)bsv^r0q!h6w4c80u==1hz_gq7w1s0l2at9o'

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set working directory
WORKDIR /usr/src/app

# copy application content
COPY . .

# install dependencies
RUN apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install --upgrade pip && \
    python3 -m pip install -r requirements.txt --no-cache-dir && \
    apk --purge del .build-deps

# run application webserver
CMD ["gunicorn", "-b", ":8000", "--workers", "3", "simpleapp.wsgi", "--access-logfile", "-", "--error-logfile", "-"]
