# Указываем базовый образ
FROM python:3.11

# Создаем группу uwsgi и пользователя uwsgi, которого и помещаем в группу
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
# Устанавливаем Python-зависимости - Flask и uWSGI
RUN pip install Flask uWSGI requests redis
# Указываем рабочую директорию
WORKDIR /app
# Копируем каталог app
COPY app /app
# Копируем скрипт
COPY cmd.sh /

# Указываем порты, которые будут нужны существующему в контейнере процессу
EXPOSE 9090 9191

# Переключаемся на пользователя uwsgi
USER uwsgi
# Выполняем стартовый скрипт для настройки
CMD ["/cmd.sh"]
