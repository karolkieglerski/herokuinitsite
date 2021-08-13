FROM python:3.9.6-alpine3.14

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy application content
COPY . .

# install dependencies
RUN apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install --upgrade pip && \
    python3 -m pip install -r requirements.txt --no-cache-dir && \
    apk --purge del .build-deps

CMD ["gunicorn", "-b", ":8000", "--workers", "3", "herokuinitsite.wsgi", "--access-logfile", "-", "--error-logfile", "-"]
