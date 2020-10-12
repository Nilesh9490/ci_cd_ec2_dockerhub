#!/bin/sh
#Get servers list
set -f
string=$DEPLOY_SERVER
array=(${string//,/ })

for i in "${!array[@]}"; do
  echo "${array[i]}"
  echo "Deploying information to EC2 and Gitlab"
  echo "Deploy project on server ${array[i]}"
  ssh ubuntu@${array[i]} "sudo docker stop demo && sudo docker rm demo && sudo docker logout &&  sudo docker login --username=$CI_REGISTRY_USER --password=$CI_REGISTRY_PASSWORD && sudo docker pull $CI_REGISTRY_IMAGE:latest && sudo docker run -it -d -p 80:80 --name demo $CI_REGISTRY_IMAGE"
done
