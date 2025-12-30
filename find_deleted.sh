#!/bin/bash

echo "🔍 Ищем процессы, держащие открытые удалённые файлы..."
lsof | grep '(deleted)' | awk '{print $2}' | sort -u | while read -r pid; do
    echo "PID: $pid | Команда: $(ps -p $pid -o comm=)"
done
