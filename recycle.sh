#!/bin/bash

# Stop associated containers, rm them, and remove the volumes
service_array=("kafka-connect" "kafka" "zookeeper" )
for service in "${service_array[@]}"; do
  echo "-> Stopping $service..."
  docker compose stop $service
  echo "-> Removing $service..."
  docker compose rm -f $service
done

echo "-> Removing $service volumes..."
docker volume rm $(docker volume ls -f "name=dev-kafka-connect" -q)