# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:3

# Copying the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

# WORKDIR is nothing but current directory (cd app)
WORKDIR /app

# Install the requirements in the current directory.
RUN pip install -r requirements.txt

# Copying the entire application to the docker container in the app directory.
COPY . /app

# Setting environmental path to app directory. path environment variables tells shell,
# which directories to search for executable files.
ENV PATH /app:$PATH

# It executes the command python app.py in the app directory.
# start gunicorn
CMD ["gunicorn","--config","/app/gunicorn_config.py","app:app"]

EXPOSE 8005