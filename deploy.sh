#!/bin/bash

docker pull subashreedocker/dev-app
docker run -d -p 80:80 subashreedocker/dev-app
