#!/bin/bash

if [ "$1" = "no_microk8s" ]; then
	helm3 uninstall chart chart
else
	microk8s helm3 uninstall chart chart
fi


