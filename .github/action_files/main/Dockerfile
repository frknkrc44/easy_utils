FROM plugfox/flutter:master

COPY entrypoint.sh /entrypoint.sh

RUN apk update && \
    apk add jq && \
    chmod +x /entrypoint.sh && \
    dart pub global activate pana

ENTRYPOINT ["/entrypoint.sh"]
