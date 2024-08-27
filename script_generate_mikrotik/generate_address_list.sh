#!/bin/bash
#Этот скрипт генерирует файл для наполнения address-list в Mikrotik, берется файлик с доменными именами ютуба а потом генерируется строки  для консоли RouterOS. Файл на выходе скачивается уже скриптом в самом Mikrotik. 
# Путь к вашему файлу с URL
input_file="youtube-url.txt"

# Путь к выходному файлу .rsc
output_file="youtube-url.rsc"

# Название адресного списка в MikroTik
address_list_name="YouTube-URL"

# Создание или очистка выходного файла
> "$output_file"

# Записываем команды для создания или очистки адресного списка
echo "/ip firewall address-list remove [find list=\"$address_list_name\"]" >> "$output_file"
echo "/ip firewall address-list add list=\"$address_list_name\" address=0.0.0.0 comment=\"Placeholder entry\"" >> "$output_file"

# Записываем команды для добавления доменов в адресный список
while IFS= read -r url; do
    if [[ -n "$url" ]]; then
        echo "/ip firewall address-list add list=\"$address_list_name\" address=\"$url\"" >> "$output_file"
    fi
done < "$input_file"

echo "Successfully created $output_file with commands."

