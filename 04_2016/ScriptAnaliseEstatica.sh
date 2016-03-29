#!/usr/bin/env bash

PATH="$PATH"

# Exportando as variáveis dos containers
CONT_POSTGRES_NAME="postgres"
CONT_SONAR_NAME="sonarqube"
CONT_JENKINS_NAME="jenkins"

# Array com os containers
CONTAINERS=( "$CONT_POSTGRES_NAME" "$CONT_SONAR_NAME" "$CONT_JENKINS_NAME" )

# Função para matar e remover os containers
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

# Função para realizar o download das imagens dos containers
function pullcontainers(){
  for c in "${CONTAINERS[@]}"; do
    docker pull $c
  done
}

# Função para executar cada container
function runcontainers(){
  for c in "${CONTAINERS[@]}"; do
    if [ $c == $CONT_POSTGRES_NAME ]; then
      docker run -d --name $CONT_POSTGRES_NAME \
      -e POSTGRES_USER="sonar" \
      -e POSTGRES_PASSWORD="SonarExample" \
      $CONT_POSTGRES_NAME
    elif [ $c == $CONT_SONAR_NAME ]; then
      docker run -d --name $CONT_SONAR_NAME \
      --link $CONT_POSTGRES_NAME:$CONT_POSTGRES_NAME \
      -p 9000:9000 \
      -p 9092:9092 \
      -e SONARQUBE_JDBC_USERNAME="sonar" \
      -e SONARQUBE_JDBC_PASSWORD="SonarExample" \
      -e SONARQUBE_JDBC_URL=jdbc:postgresql://$CONT_POSTGRES_NAME:5432/sonar \
      $CONT_SONAR_NAME
    elif [ $c == $CONT_JENKINS_NAME ]; then
      docker run -d --name $CONT_JENKINS_NAME \
      -p 8080:8080 \
      -p 50000:50000 \
      $CONT_JENKINS_NAME
    fi
  done
}

# Função para checar se o container está rodando ou não
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

# Função para buscar e apresentar os IPs de cada container
function getinfofromcontainers(){
  for c in "${CONTAINERS[@]}"; do
    IP=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $c)
    if [ $c == $CONT_POSTGRES_NAME ]; then
      echo "O $CONT_POSTGRES_NAME está com o IP: $IP"
    elif [ $c == $CONT_SONAR_NAME ]; then
      echo "O $CONT_SONAR_NAME está com o IP: $IP"
    elif [ $c == $CONT_JENKINS_NAME ]; then
      echo "O $CONT_JENKINS_NAME está com o IP: $IP"
    fi
    done
  }

# Condição para invocar as funções
if `which docker > /dev/null`; then
  clearcontainers
  pullcontainers
  runcontainers
  statuscontainers
  getinfofromcontainers
else
  echo "Docker não instalado"
fi
