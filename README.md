Скрипт который добавляет в адрес листы Mikrotik адреса URL или адреса ip с маской /32 и с более широкой маской /24
Тип дабавление адресов разделен тут на 3 папки. 
  1. script_generate_mikrotik
     generate_address_list.sh - скрипт который генерирует срисок адрес листа (берет списки из  youtube-url.txt и создает youtube-url.rsc ) (Запускается в bash)
     mikrotik_import - скрипт обновления адрес листов в вашей ROS (кладется в /system/script) (запускается на Mikrotik)
     youtube-url.rsc - сгенерированные списки. этот адрес лист скачивается скриптом  mikrotik_import  который вы поместили в вашу ROS
     Есть вы хотите сами генерировтаь свои адрес листы или будете его править то скачайте все на свой ПК, сгенерируйте адрес лист и добавьте скрипт в ваш ROS. Ну и поменяйте адрес откуда будет лист качатся.
     Внимание! Так как тут url адреса YouTube то при загрузке их на вашу ROS будет использоваться процессорная мощность вашего устройства а так же  при разрешения DNS имен. При исчерпании TTL DSN записи она будет обновлятся австоматически.
     Учтите это. Всего 828 строчки URL и примерно 2659 строк записи в кеше DNS ROS. Скрипт перен началом работы очищает кеш а так же удаляет прошлый адрес лист с тем же названием. 
  2. script_generate_mikrotik_ip - папка с тем же  по логике содержимым что и в п. 1 но тут списки IP адресов с маской /32. Список адресов очень большой но он точный по сравнению чем суммаризированный по маске /24 и более. Содержит 11 644 строки.
     Так же при повторном запуске он очищает предыдущий адрес лист с тем же названием. 
  3. script_generate_mikrotik_ip_cidr - тут все тоже самое что и в п. 2 но более широкая маска соотвественно более широкие диапазоны адресации. Возможно использовать на слабых устройствах но тут есть минут это попадаение какого то сервиса кроме YouTube
     в диапазон. Всего 483 строчки адресов. Логика работы скрипта такая же как и в п.2.

Перед добавлением адрес листа:
Эти списки предпологают что у вас уже настроены правила маркировки пакетов (mangle) в таблице prerouting. Если у вас включен FastTrack то нужно либо отключить его либо попросить ROS  не заводить трафик через FastTrack. 
Будет выглядить эта настройка примерно так:
/ip firewall filter add chain=forward action=fasttrack-connection connection-state=established,related routing-mark=!my-routing-mark
Без этого правила у вас будет загружаться  YouTube не полностью. Если вы отключили FastTrack вообще и у вас ваша железо позволяет это то этот шаг пропускаете.
Так же убедитесь что у вас настроен или указан DNS сервер в настройках. Учтите что провайдер может филтровать ваши DNS запросы. В этом случае организуйие DOH на ROS  или Pi-hole в докере или другом сервисе.

Все скрипты работают без отвалов и overhead CPU на устрйостве RBD52G-5HacD2Hn (HAP AC2) 4 ядерный ARM процессор. 
