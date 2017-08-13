FROM alpine:3.6

ARG OINKCODE
ARG SNORT_RULES=2990

RUN apk add --no-cache curl snort openssh-client && \
    curl -L https://www.snort.org/rules/snortrules-snapshot-$SNORT_RULES.tar.gz?oinkcode=$OINKCODE | tar xz -C /var/lib/snort && \
    ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

VOLUME /var/lib/snort/rules

WORKDIR /app
COPY entrypoint.sh /app/
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
