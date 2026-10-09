#!/bin/bash
# Скрипт для автоматического выполнения Лабораторной работы №1 (Вариант 12)
# Студент: ИСУ 561776

echo "=== Шаг 1: Создание структуры папок ==="
cd ~
mkdir -p lab0/claude_monet/kitchen/hot_station lab0/claude_monet/kitchen/cold_room lab0/claude_monet/sanitation lab0/claude_monet/cleaning lab0/claude_monet/hall lab0/claude_monet/office
touch lab0/claude_monet/kitchen/hot_station/hot_report lab0/claude_monet/kitchen/hot_station/senya_check lab0/claude_monet/kitchen/cold_room/fridge_temperature lab0/claude_monet/kitchen/cold_room/fish_check lab0/claude_monet/sanitation/inspection_act lab0/claude_monet/sanitation/violations lab0/claude_monet/cleaning/cleaning_schedule lab0/claude_monet/hall/waiter_note lab0/claude_monet/office/vika_response lab0/inspector_arrival

echo "=== Наполнение файлов содержимым ==="
printf "Горячий цех подготовлен к проверке\nРабочие поверхности очищены\nБаринов проверил порядок лично\n" > ~/lab0/claude_monet/kitchen/hot_station/hot_report
printf "Сеня убрал лишние продукты\nНожи лежат на своих местах\nСрок хранения мяса не нарушен\n" > ~/lab0/claude_monet/kitchen/hot_station/senya_check
printf "Утром температура четыре градуса\nДнём температура пять градусов\nВечером температура четыре градуса\n" > ~/lab0/claude_monet/kitchen/cold_room/fridge_temperature
printf "Федя проверил сибаса и дорадо\nСвежая рыба перенесена в холодильник\nНарушений хранения рыбы нет\n" > ~/lab0/claude_monet/kitchen/cold_room/fish_check
printf "Проверка началась до открытия ресторана\nИнспектор осмотрел кухню и зал\nПовторная проверка назначена на пятницу\n" > ~/lab0/claude_monet/sanitation/inspection_act
printf "Нарушен порядок хранения одной коробки\nНарушена маркировка контейнера с соусом\nГрафик уборки висит не на своём месте\n" > ~/lab0/claude_monet/sanitation/violations
printf "Уборка кухни проводится утром\nУборка зала проводится перед открытием\nВечером Лёва проверяет результат уборки\n" > ~/lab0/claude_monet/cleaning/cleaning_schedule
printf "Официанты убрали столы перед проверкой\nНастя проверила гостевую зону\nЗапасные скатерти сложены в шкаф\n" > ~/lab0/claude_monet/hall/waiter_note
printf "Вика получила акт инспектора\nЗамечания будут исправлены до вечера\nОтветственным назначен Лёва\n" > ~/lab0/claude_monet/office/vika_response
printf "Инспектор приехал раньше назначенного времени\nБаринов встретил проверку на кухне\nНагиев потребовал избежать штрафа\n" > ~/lab0/inspector_arrival

echo "=== Шаг 2: Инициализация Git и настройка прав доступа ==="
cd ~/lab0
git init
git config --global user.email "student@example.com"
git config --global user.name "Student"

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod 750 claude_monet/kitchen/hot_station
chmod u=rw,g=r,o= claude_monet/kitchen/hot_station/hot_report
chmod 640 claude_monet/kitchen/hot_station/senya_check
chmod 750 claude_monet/kitchen/cold_room
chmod 644 claude_monet/kitchen/cold_room/fridge_temperature
chmod u=rw,g=r,o= claude_monet/kitchen/cold_room/fish_check
chmod 750 claude_monet/sanitation
chmod u=rw,g=r,o= claude_monet/sanitation/inspection_act
chmod 640 claude_monet/sanitation/violations
chmod u=rwx,g=rx,o= claude_monet/cleaning
chmod 644 claude_monet/cleaning/cleaning_schedule
chmod 755 claude_monet/hall
chmod u=rw,g=r,o=r claude_monet/hall/waiter_note
chmod 750 claude_monet/office
chmod 640 claude_monet/office/vika_response
chmod u=rw,g=r,o= inspector_arrival

git add .
git commit -m "Part 1: Directory tree and permissions configured"

echo "=== Шаг 3: Копирование, перемещение и создание ссылок ==="
cp inspector_arrival claude_monet/office/arrival_copy
cp -r claude_monet/cleaning claude_monet/sanitation/cleaning_backup
ln -s claude_monet/sanitation/inspection_act inspection_link
ln -s ../sanitation claude_monet/kitchen/sanitation_access
ln claude_monet/sanitation/inspection_act claude_monet/sanitation/act_duplicate
cat claude_monet/kitchen/hot_station/hot_report claude_monet/kitchen/cold_room/fish_check > claude_monet/kitchen/stations_report
cat claude_monet/sanitation/violations >> claude_monet/office/vika_response
mv claude_monet/hall/waiter_note claude_monet/office/guest_zone_note

git add .
git commit -m "Part 2: Copying, moving and links completed"

echo "=== Шаг 4: Поиск и фильтрация данных ==="
echo "Задание 1:"
ls -lR | grep "^-" | sort -k5 -n -r | head -n 5
echo "Задание 2:"
grep -r -h -i -E "наруш|проверк" claude_monet | grep -v "повторн" | sort -r | head -n 6
echo "Задание 3:"
grep -l "уборк" claude_monet/cleaning/* claude_monet/sanitation/cleaning_backup/* 2>/dev/null | wc -l
echo "Задание 4:"
tail -n +1 claude_monet/kitchen/hot_station/*_report claude_monet/kitchen/hot_station/*_check claude_monet/kitchen/cold_room/*_report claude_monet/kitchen/cold_room/*_check 2>/dev/null | grep -v "==>" | grep -v "^$" | sed -n '1p;$p' | grep -i -E "провер|наруш" | sort
echo "Задание 5:"
grep -v "Баринов" claude_monet/kitchen/stations_report | grep -E "провер|рыб" | sort -r | wc -w
echo "Задание 6:"
ls -lR | grep "^-" | awk '$2 == 2 {print $0}' | sort -k9
echo "Задание 7:"
ls -lR | grep "^l" | sort -k9 -r | head -n 1

git add .
git commit -m "Part 3: Data search, filtration and processing completed"

echo "=== Шаг 5: Удаление файлов и папок ==="
rm claude_monet/office/arrival_copy
rm inspection_link
rm claude_monet/kitchen/sanitation_access
rm claude_monet/sanitation/act_duplicate
rm claude_monet/office/guest_zone_note
rmdir claude_monet/hall
rm claude_monet/sanitation/violations
rm -r claude_monet/sanitation/cleaning_backup

git add .
git commit -m "Part 3: Removal of files and directories completed"
echo "=== Все команды успешно выполнены! ==="
