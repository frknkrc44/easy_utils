FROM plugfox/flutter:stable

COPY entrypoint.sh /entrypoint.sh

RUN apk update && \
    apk add jq && \
    dart pub global activate pana && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
