#!/usr/bin/env bash

SUBNET="192.168.1"

for i in {1..254}; do
    (
     	ping -c1 -W1 $SUBNET.$i &>/dev/null && echo "$SUBNET.$i доступен"
    ) &
done
wait
