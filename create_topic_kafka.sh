#!/bin/bash
# create-topics.sh
# Массовое создание топиков

KAFKA_HOME="/opt/kafka"
BOOTSTRAP_SERVER="localhost:9092"

# Список топиков
declare -A TOPICS=(
    ["user-events"]="partitions=12,replication-factor=3"
    ["order-events"]="partitions=6,replication-factor=3"
    ["notification-events"]="partitions=3,replication-factor=3"
)

for topic in "${!TOPICS[@]}"; do
    echo "Creating topic: $topic"
    IFS=',' read -ra PARAMS <<< "${TOPICS[$topic]}"
    
    PARTITIONS=""
    REPLICATION=""
    
    for param in "${PARAMS[@]}"; do
        if [[ $param == partitions=* ]]; then
            PARTITIONS="${param#*=}"
        elif [[ $param == replication-factor=* ]]; then
            REPLICATION="${param#*=}"
        fi
    done
    
    $KAFKA_HOME/bin/kafka-topics.sh --create \
        --topic "$topic" \
        --bootstrap-server $BOOTSTRAP_SERVER \
        --partitions $PARTITIONS \
        --replication-factor $REPLICATION \
        --if-not-exists
    
    echo "✓ Topic $topic created"
done
