# wpull-website-clone
This is a dockerized website cloning tool utilizing wpull

# Usage
## Build
Build and tag using your prefered name.
```bash
docker build -t wpull-website-clone:latest .
```
## Run
Run your image passing your variables.
```bash
docker run --rm -it --user $(id -u ${USER}):$(id -g ${USER}) -e WEBSITE=<WEBSITE_TO_CLONE> -e LEVEL=1 -e WAIT=0.1 -v ${PWD}:/app wpull-website-clone:latest
```
You need to specify user and mount volumes for this to properly work and produce the expected results. Check `Dockerfile` for all variables you can pass inside the docker environment.
## Result
This will produce a directory that includes all website specified cloned contents, a log file and a warc zipped file.