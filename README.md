# geoserver-docker
## Minimal GeoServer instance for Docker

Runs on Alpine and default jetty server.  Could probably use some additional modifications for running in production.
Added the importer plugin but not much else at this point...
Suggestions welcome...

To run detached,

    docker run -d -p 8080:8080 druidsmith/geoserver /bin/sh startup.sh
