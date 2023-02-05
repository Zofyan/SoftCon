#!/bin/bash

# will take local docker images and upload them to the vcs.
# note: this will take a LONG time.
sudo docker tag rest-api:local iaotle/rest-api
sudo docker tag my-postgres:local iaotle/my-postgres
sudo docker tag frontendapp:local iaotle/frontendapp


docker push iaotle/rest-api
docker push iaotle/my-postgres
docker push iaotle/frontendapp
