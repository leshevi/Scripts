#!/usr/bin/env bash

LOG_FILE="/var/log/auth.log"
LIMIT=50
BOT_TOKEN=""
CHAT_ID=""

grep -E "Failed password for" "$LOG_FILE" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -nr | awk -v limit="$LIMIT" '$1 > limit {print $2}' |
while read ip; do
  if ! iptables -L INPUT -v -n | grep -q "$ip"; then
    iptables -I INPUT -s "$ip" -j DROP
    echo "$(date): Заблокирован IP $ip" >> /var/log/ssh_ban.log
  fi
done
OUTPUT=/var/log/ssh_ban.log

curl -F chat_id="$CHAT_ID" -F document=@"$OUTPUT" https://api.telegram.org/bot"$BOT_TOKEN"/sendDocument
