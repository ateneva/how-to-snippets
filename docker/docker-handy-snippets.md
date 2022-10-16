
# Images

```bash
docker image ls -a                         # list all docker images
docker image ls                            # list the images in the local repo
docker image rm <image id>                 # remove a docker image
docker image rm $(docker image ls -a -q)   # remove image on windows
```

## Building images

```bash
docker build -t <image name> .            # create the image 
```

# Containers

```bash
docker container ls                       # list all running containers
docker container ls -a                    # list all containers
docker container stop <container id>      # gracefuly stop containers
docker container kill <container id>      # force quit containers
docker container rm <container id>        # delete containers
docker container run <image name>         # run the image
docker container run -it <image name>     # run the image and interact with it

# run an image called olympics
docker container run olympics

# run the olympics image on a a specific port
docker container run -p 8888:8888 olympics  

# run the image called `bash` by using
docker container run -it -v "%cd%": /data dev-env bash 
```

* <https://docs.docker.com/engine/reference/commandline/container_rm/>

* <https://docs.docker.com/engine/reference/commandline/container_run/>

## Building (Re-creating) containers

```bash
docker-compose -f docker-compose.yml up
docker-compose -f docker-compose.yml up --force-recreate
```

* <https://docs.docker.com/compose/reference/up/>

* <https://stackoverflow.com/questions/52106464/what-is-the-difference-between-the-build-and-force-recreate-flags-to-do>

* <https://stackoverflow.com/questions/47081505/docker-compose-force-recreate-specific-service>

### copy all files from a local folder to existing container

```bash
# copy a single file from a local folder to a folder inside existing container
docker cp ./src/build/index.html <container name>:/app/

# copy all files from a local folder to a folder inside existing container
docker cp <local path>. <container name>:/<folder on container>/
docker cp /Users/angelina.teneva/Documents/postgres/sample_db/. postgres_dvd_rental_1/:/home/
```

* <https://stackoverflow.com/questions/32566624/docker-cp-all-files-from-a-folder-to-existing-container-folder>

### Execute a command on a running container

```bash
#start the container
docker run --name ubuntu_bash --rm -i -t ubuntu bash       

# make files from host machine available on container
docker run -v /host_dir:/container_dir ...                 

### execute a command on a running container
docker exec -d ubuntu_bash touch /tmp/execWorks            

### execute an interactive command
docker exec -it ubuntu_bash bash                           
```

[**Note:**](https://stackoverflow.com/questions/27673563/how-to-get-into-psql-of-a-running-postgres-container)

* `docker exec` runs the command on a running container
* `docker run` will start a new container.

* <https://docs.docker.com/engine/reference/commandline/exec/>

### handy container commands

```bash
# run psql inside a postgresql container
docker exec -ti <container id> psql -U user database
docker exec -ti <container name> psql -U user database
docker exec -ti postgres_dvd_rental_1 psql -U ateneva dvd
```

# Docker files

```bash
# use the official image as a parent image
FROM python: 3.7.3-slim    

# add labels to help organize images by project
LABEL mainteiner= "Angelina Teneva <tenevaa21@gmail.com>"
LABEL version = "0.1"
LABEL description = "My project"

# set the working directory
WORKDIR /data      

# ensure credentials are available in the image
VOLUME ["/secrets"]

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

# Pulling latest image

```bash

```

## Pushing image to Container Registry (GCP)

```bash
docker pull busybox
docker tag busybox gcr.io/my-project/busybox
docker push gcr.io/my-project/busybox
```

## Pushing image to ECS (AWS)

```bash
```

# References

* <https://cloud.google.com/container-registry/docs/pushing-and-pulling>
