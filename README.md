# ve-annotations
A W3C Web Annotation Server forked from https://github.com/azaroth42/MangoServer

The forked MangoServer has been updated to provide Python 3 compatibility and support
for use of a hosted MongoDB server at https://www.mongodb.com/cloud/atlas

# Running locally

```bash
docker build -t mango .
docker run -it -p 8080:8080 mango
```

# Deploying to Google Cloud Run

```bash
./gcr-deploy.sh
```
