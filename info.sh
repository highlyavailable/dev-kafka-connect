#!/bin/bash

# Grabs metadata from Kafka and Kafka Connect to check the status of the cluster
SERVER_PROPERTIES_PATH="/etc/kafka/server.properties"
META_PROPERTIES_PATH="/var/lib/kafka/data/meta.properties"

echo
echo "Fetching Kafka Broker ID..."
docker compose exec kafka bash -c "cat $SERVER_PROPERTIES_PATH | grep broker.id"

echo
echo "Fetching Kafka Cluster ID..."
docker compose exec kafka bash -c "cat $META_PROPERTIES_PATH | grep cluster.id"

echo
echo "Existing Kafka Topics..."
docker compose exec kafka kafka-topics --bootstrap-server localhost:9092 --list

echo
echo "Running Connectors..."
docker compose exec kafka-connect curl -s "http://localhost:8083/connectors" | jq '.'

echo
echo "Available Connector Plugins..."
docker compose exec kafka-connect curl -s "http://localhost:8083/connector-plugins" | jq '.'