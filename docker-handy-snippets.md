
## Images

```
docker image ls -a                         # list all docker images
docker image ls                            # list the images in the local repo
docker image rm <image id>                 # remove a docker image
docker image rm $(docker image ls -a -q)   # run in windows
```

### Building images 
```
docker container run -it -v "%cd%": /data dev-env bash
docker build -t <image name> .   # create the image 
docker image ls
docker container run -p 8888:8888 olympics
```


## Containers
```
docker container ls                       # list all running containers
docker container ls -a
docker container stop <container id>      # greacefuly stop containers
docker container kill <container id>      # force quit containers
docker container rm <container id>        # delete contaners
docker container run <image name>         # run the image
docker container run -it <image name>     # run the image and interact with it
```
https://docs.docker.com/engine/reference/commandline/container_rm/
https://docs.docker.com/engine/reference/commandline/container_run/

### Building (Re-creating) containers
```
docker-compose -f docker-compose.yml up
docker-compose -f docker-compose.yml up --force-recreate
```
https://docs.docker.com/compose/reference/up/
https://stackoverflow.com/questions/52106464/what-is-the-difference-between-the-build-and-force-recreate-flags-to-do
https://stackoverflow.com/questions/47081505/docker-compose-force-recreate-specific-service

### Execute a command on a running container
```
### start the container
 docker run --name ubuntu_bash --rm -i -t ubuntu bash
 
### execute a command on the container
docker exec -d ubuntu_bash touch /tmp/execWorks

### execute an interactive command 
 docker exec -it ubuntu_bash bash
```
https://docs.docker.com/engine/reference/commandline/exec/

## Dpcker files
```
# use the official image as a parent image
FROM python: 3.7.3-slim    

# add labels to help organize images by project
LABEL mainteiner= "Angelina Teneva <tenevaa21@gmail.com>"
LABEL version = "0.1"
LABEL description = "Summer Olympics project"

# set the working directory
WORKDIR /data      

# copy all the files from current directory 
# and add them to working directory of container
COPY . /data       

# will execute any command in the new layer on top of current image
# it's better to have fewer RUN statements and split them across multiple lines
RUN pip install numpy &&/
    pip install pandas &&/
    pip install seaborn &&/
    pip install jupyter                     # install dependencies

# RUN pip install -r requirements.txt       # or install via text file

# indicate the ports to which the container listens for connections
EXPOSE 8888       

# there can be only 1 CMD instruction per a docker file
# if you have more than 1, the last one will take effect
# CMD tells the container what it should do after launching
CMD["python", "app.py"]

```