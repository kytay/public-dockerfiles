# ALPINE-KNOCK

This is a docker image to package `BentonEdmondson/knock`.
To use this docker image
```bash
# To build
docker build -t alpine-knock .
# To run
docker run -v </path/to/acsm_files>:/tmp -it --rm alpine-knock 
```
