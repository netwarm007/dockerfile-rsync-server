FROM ubuntu
MAINTAINER Chen, Wenli <chenwenli@chenwenli.com>

RUN apt-get -qq update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends rsync && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 873
VOLUME /data
ADD ./run.sh /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
