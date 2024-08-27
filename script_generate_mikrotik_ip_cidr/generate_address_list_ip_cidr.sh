#!/bin/bash

# Название входного файла
input_file="cidr4.txt"

# Название выходного файла
output_file="add_cidr_to_mikrotik.rsc"

# Комментарий к address list
comment="YouTube-IP-CIDR"

# Обнуление или создание выходного файла
> "$output_file"

# Счетчики
total_lines=0
processed_lines=0

# Чтение файла построчно
while IFS= read -r line; do
    # Увеличиваем счетчик строк
    ((total_lines++))
    
    # Проверяем, что строка не пуста
    if [[ -n "$line" ]]; then
        # Формируем строку добавления в адрес-лист
        echo "/ip firewall address-list add list=$comment address=$line comment=\"$comment\"" >> "$output_file"
        ((processed_lines++))
    fi
done < "$input_file"

# Вывод статистики
echo "Обработано строк: $total_lines"
echo "Сгенерировано записей: $processed_lines"
echo "Размер выходного файла: $(stat -c%s "$output_file") байт"
