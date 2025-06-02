FROM plugfox/flutter:latest

COPY entrypoint.sh /entrypoint.sh

RUN apt update && \
    apt install jq -y && \
    chmod +x /entrypoint.sh && \
    dart pub global activate pana

ENTRYPOINT ["/entrypoint.sh"]
