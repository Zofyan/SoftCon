#!/bin/bash

if [ "$1" = "no_microk8s" ]; then
	helm install chart chart
else
	microk8s helm3 install chart chart
fi
