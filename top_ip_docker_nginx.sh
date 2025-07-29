#!/usr/bin/env bash

# --------------------------------------------
# Скрипт для поиска топ-N IP-адресов в логах
# Автор: @bash_srv
# --------------------------------------------

# Путь к лог-файлу (по умолчанию /var/log/nginx/access.log)
LOGFILE="/home/leshevi/nginx/log/access.log"

# Сколько адресов показать (по умолчанию 10)
TOP_N=10

# Временный файл для списка всех IP
TEMP="/tmp/all_ips_$(date +%Y%m%d_%H%M%S).txt"
# Данные бот телеграм
BOT_TOKEN=""
CHAT_ID=""

# Проверка, что лог-файл существует
if [[ ! -f "$LOGFILE" ]]; then
  echo "❌ Лог-файл '$LOGFILE' не найден!"
  exit 1
fi

echo "🔎 Извлекаем IP-адреса из $LOGFILE и рассчитываем топ $TOP_N..."

# 1. Извлекаем первый столбец (обычно там IP), записываем во временный файл
awk '{print $NF}' "$LOGFILE" > "$TEMP"

OUTPUT="/tmp/top_ips_report.txt"
sort "$TEMP" | uniq -c | sort -nr | head -n "$TOP_N" > "$OUTPUT"
curl -F chat_id="$CHAT_ID" -F document=@"$OUTPUT" https://api.telegram.org/bot"$BOT_TOKEN"/sendDocument
# 3. Убираем временный файл
rm -f "$TEMP"
