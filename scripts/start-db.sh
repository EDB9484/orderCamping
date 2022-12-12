#!/bin/bash

################################################################
# PostgreSQL 
################################################################
POSTGRES_NAME=postgres
POSTGRES_IMAGE=postgres
POSTGRES_IMAGE_TAG=15
POSTGRES_HTTP_PORT=5432
POSTGRES_PASSWORD=Password1234
POSTGRES_FULL_IMAGE=$POSTGRES_IMAGE:$POSTGRES_IMAGE_TAG

nerdctl stop $POSTGRES_NAME 
nerdctl rm $POSTGRES_NAME
nerdctl run -d \
    -p $POSTGRES_HTTP_PORT:5432 \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    --restart always \
    --net bridge \
    --name $POSTGRES_NAME \
    $POSTGRES_FULL_IMAGE

################################################################
# PGADMIN 
################################################################
PGADMIN_NAME=pgadmin4
PGADMIN_IMAGE=dpage/pgadmin4
PGADMIN_IMAGE_TAG=6.14
PGADMIN_HTTP_PORT=9999
PGADMIN_DEFAULT_EMAIL=admin@eland.co.kr
PGADMIN_DEFAULT_PASSWORD=Password1234
PGADMIN_FULL_IMAGE=$PGADMIN_IMAGE:$PGADMIN_IMAGE_TAG

nerdctl stop $PGADMIN_NAME
nerdctl rm $PGADMIN_NAME
nerdctl run -p $PGADMIN_HTTP_PORT:80 \
    -e PGADMIN_DEFAULT_EMAIL=$PGADMIN_DEFAULT_EMAIL \
    -e PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD \
    -e PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True \
    --restart always \
    --net bridge \
    --name $PGADMIN_NAME \
    -d $PGADMIN_FULL_IMAGE


nerdctl ps 