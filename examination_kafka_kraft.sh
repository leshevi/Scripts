#!/bin/bash
# kafka-health-check.sh
# Скрипт для проверки состояния кластера

KAFKA_HOME="/opt/kafka"
BOOTSTRAP_SERVER="localhost:9092"

# Проверка доступности брокеров
echo "Checking broker availability..."
$KAFKA_HOME/bin/kafka-broker-api-versions.sh --bootstrap-server $BOOTSTRAP_SERVER >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✓ Brokers are accessible"
else
    echo "✗ Brokers are not accessible"
    exit 1
fi

# Проверка контроллеров
echo "Checking controller status..."
ACTIVE_CONTROLLER=$($KAFKA_HOME/bin/kafka-metadata-shell.sh --snapshot /var/lib/kafka-logs/__cluster_metadata/00000000000000000000.log --print-brokers 2>/dev/null | grep -c "ACTIVE")
if [ $ACTIVE_CONTROLLER -eq 1 ]; then
    echo "✓ Controller is active"
else
    echo "✗ Controller issues detected"
    exit 1
fi

# Проверка under-replicated партиций
echo "Checking under-replicated partitions..."
UNDER_REPLICATED=$($KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --describe --under-replicated-partitions 2>/dev/null | wc -l)
if [ $UNDER_REPLICATED -eq 0 ]; then
    echo "✓ All partitions are properly replicated"
else
    echo "⚠ Found $UNDER_REPLICATED under-replicated partitions"
fi

echo "Health check completed"
