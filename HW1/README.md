# ДЗ 1

## Что сделано
1. Поднят инстанс PostgreSQL в Docker в `docker-compose.yaml`
2. Написан DDL для структуры выше в SQL-файл в `init.sql`
3. Настроена автоматическая инициализация БД c данной структурой 
4. Поднята реплика в docker-compose, настроена репликация на основе демо 2 из семинара 2
5. Написана view для расчёта GMV и реализоана в `init.sql`


## Как запустить
1. Делаем клон репозитория
2. `docker-compose build`
3. `docker-compose up`
4. Всё готово, можно тестировать через Dbeaver с заливкой данных

Вьюшку сделал, реплику сделал, мастер сделал
