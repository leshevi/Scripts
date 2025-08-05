#!/usr/bin/env bash

while true; do
    clear
    echo "🖥  CPU Load Monitor"
    echo "----------------------"
    mpstat 1 1 | awk '/Average/ {print "Загрузка CPU: " 100 - $NF "%"}'
    sleep 1
done
