FROM python:3.8

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
    ; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9; \
    apt-add-repository 'deb http://repos.azulsystems.com/debian stable main'; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        tini \
    ; \
    apt-get clean; \
    rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*

RUN set -e; \
    pip install bottle html5lib isodate keepalive PyLD pymongo==3.11 dnspython pyparsing pytz rdflib requests six SPARQLWrapper webencodings uwsgi

WORKDIR /usr/src/app

ADD contexts contexts
ADD mangoserver.py src/mangoserver.py
ADD config.json config.json
ADD atlas-creds atlas-creds
RUN echo '' > src/__init__.py

ENV PORT 8080

ENTRYPOINT ["tini", "--"]
# CMD uwsgi --http :${PORT} --manage-script-name --mount /app=src.mangoserver:application --enable-threads --processes 8
CMD uwsgi --http :${PORT} --manage-script-name --mount /app=src.mangoserver:application --processes 1

