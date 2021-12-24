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
You need to specify user and mount volumes for this to properly work and produce the expected results. Check `Dockerfile` for all variables you can pass inside the docker environment. \
You can also instantly run a web server that hosts your cloned website by adding a simple `SRV_PORT` parameter to your environment and expose this port.
```bash
docker run --rm -it --user $(id -u ${USER}):$(id -g ${USER}) -p 80:80 -e WEBSITE=<WEBSITE_TO_CLONE> -e LEVEL=1 -e WAIT=0.1 -e SRV_PORT=80 -v ${PWD}:/app wpull-website-clone:latest
```
![ksnip_20211224-153216](https://user-images.githubusercontent.com/10864434/147356213-371f90b4-48e1-4543-a04f-584047edf9aa.png)
## Keep in mind
After running files are created on your filesystem (wherever you specified them). Also when running the web server you need these files to serve your cloned website. This is best practice, but it works pretty well and does your trick. \
Also cloning websites and tricking users into harvesting traffic or credentials is not legal and you should use only for educational purposes.
## Result
This will produce a directory that includes all website specified cloned contents, a log file and a warc zipped file. \
If you specify an `SRV_PORT` you will also host a simple HTTP web server and serve your cloned content.
