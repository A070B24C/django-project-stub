FROM pahaz/base:v1.4

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /app /static /media /cache && chown -R unprivileged:unprivileged /media /cache
WORKDIR /app

COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENV STATIC_ROOT /static
ENV MEDIA_ROOT /media

COPY . /app
RUN chmod +x /app/docker-prepare.sh && chmod +x /docker-entrypoint.sh && /app/docker-prepare.sh

VOLUME ["/static", "/app"]
ENTRYPOINT ["/docker-entrypoint.sh"]
