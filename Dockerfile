FROM python:3.8-alpine

MAINTAINER Rik Schoonbeek

ENV PYTHONUNBUFFERED 1

# From the same directory as the dockerfile is in copy the requirements.txt (./requirements.txt) file and copy it
# to the docker image to /requirements.txt
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create dir on image to store app source code
RUN mkdir /app
# Set this new app as default directory, so any application we run using our docker container will run
# starting from this location, unless we specify otherwise
WORKDIR /app
COPY ./app /app

# Create user (named user, here) to run our application
# -D means creating a user that is used for running applications only.
RUN adduser -D user
# Switch to newly created user
USER user
# NOTE the reason the above is done is for security purposes, if you don't do this our image will run our application
# using the root account, which is not recommended. If someone compromises our application, they can then have root
# access to the whole image.
