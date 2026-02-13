FROM docker:stable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh; apt-get update; apt-get upgrade; docker version
ENTRYPOINT ["/entrypoint.sh"]
