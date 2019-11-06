#!/bin/bash
cd "$(dirname "$0")"
cd ..

cur_path="$(pwd)"
echo $cur_path

docker_name=cpi
docker build -t $docker_name .
docker stop $docker_name
docker rm $docker_name
docker run --gpus all \
               -it -v $cur_path/dataset:/app/dataset \
               -v $cur_path/output:/app/output \
               -v $cur_path/notebook:/app/notebook \
               --name $docker_name -p 9999:8888 $docker_name


#docker run -it --rm cpi bash


