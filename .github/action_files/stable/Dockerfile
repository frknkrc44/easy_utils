FROM plugfox/flutter:stable

COPY entrypoint.sh /entrypoint.sh

RUN curl -L https://github.com/jqlang/jq/releases/download/jq-1.8.0/jq-linux-amd64 > /usr/bin/jq && \
    chmod +x /usr/bin/jq /entrypoint.sh && \
    dart pub global activate pana

ENTRYPOINT ["/entrypoint.sh"]
