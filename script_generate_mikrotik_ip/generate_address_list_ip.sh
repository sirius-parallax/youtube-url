#!/bin/bash

# Путь к вашему файлу с IPv4 адресами
input_file="ipv4_list.txt"

# Путь к выходному файлу .rsc
output_file="add_ip_to_mikrotik.rsc"

# Название адресного списка в MikroTik
address_list_name="YouTube-IP"

# Инициализация счетчиков
processed_count=0
added_count=0

# Создание или очистка выходного файла
> "$output_file"

# Записываем команды для создания или очистки адресного списка
echo "/ip firewall address-list remove [find list=\"$address_list_name\"]" >> "$output_file"

# Записываем команды для добавления IP-адресов в адресный список
while IFS= read -r ip; do
    ((processed_count++))
    if [[ -n "$ip" ]]; then
        echo "/ip firewall address-list add list=\"$address_list_name\" address=\"$ip\"" >> "$output_file"
        ((added_count++))
    fi
done < "$input_file"

# Получаем размер выходного файла
output_file_size=$(stat -c%s "$output_file")

# Вывод статистики
echo "Обработано строк: $processed_count"
echo "Добавлено записей: $added_count"
echo "Размер выходного файла: $output_file_size байт"
echo "Успешно создан $output_file с командами."
