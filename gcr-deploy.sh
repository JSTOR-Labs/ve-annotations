#!/bin/bash

rm -rf build
mkdir build
rsync -va --exclude=venv Dockerfile mangoserver.py config.json atlas_creds contexts build
cd build
gcloud builds submit --tag gcr.io/visual-essay/annotations
gcloud beta run deploy annotations --image gcr.io/visual-essay/annotations --allow-unauthenticated --platform managed --memory 1Gi
