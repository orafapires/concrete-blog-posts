#!/usr/bin/env bash

PATH="$PATH"

CONT_JENKINS_NAME="jenkins"
CONT_SONAR_NAME="sonarqube"
CONTAINERS=( "$CONT_JENKINS_NAME" "$CONT_SONAR_NAME" )

function clearcontainers(){
  for c in "${CONTAINERS[@]}"; do
    ISRUNNING=$(docker ps | grep -o "$c")
    if [ -n "$ISRUNNING" ]; then
      docker kill $c
      docker rm $c
    else
      echo "Container $c parado"
    fi
  done
}

function pullcontainers(){
  for c in "${CONTAINERS[@]}"; do
    docker pull $c
  done
}

function runcontainers(){
  for c in "${CONTAINERS[@]}"; do
    if [ $c == $CONT_JENKINS_NAME ]; then
      docker run -d --name $CONT_JENKINS_NAME -p 8080:8080 -p 50000:50000 $CONT_JENKINS_NAME
    elif [ $c == $CONT_SONAR_NAME ]; then
      docker run -d --name $CONT_SONAR_NAME -p 9000:9000 -p 9092:9092 $CONT_SONAR_NAME
    fi
  done
}

function statuscontainers(){
  for c in "${CONTAINERS[@]}"; do
    STATUS=$(docker inspect --format="{{ .State.Running }}" $c)
    NAMES=$(docker inspect --format="{{ .Name }}" $c | cut -d'/' -f2)
    if [ $STATUS == "true" ]; then
      echo "Container $NAMES rodando"
    else
      echo "Container $NAMES parado"
      STATUS=$(docker inspect --format="{{ .State.Error }}" $c)
      echo "Erro:" $STATUS
    fi
  done
}

if `which docker > /dev/null`; then
  clearcontainers
  pullcontainers
  runcontainers
  statuscontainers
else
  echo "Docker não instalado"
fi
