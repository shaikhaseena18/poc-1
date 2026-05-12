#!/bin/bash

IMAGE_NAME=devsecops-app:latest

echo "Running Trivy scan..."
trivy image --severity HIGH,CRITICAL $IMAGE_NAME
