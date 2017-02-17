FROM ubuntu:xenial

RUN apt-get update && \
  apt-get install -y wget perl build-essential libssl-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PERL_MM_USE_DEFAULT 1

RUN cpan CPAN && \
  cpan Net::DNS && \
  cpan Net::SSLinfo && \
  cpan Net::SSLeay && \
  cpan IO::Socket::SSL

ENV DOWNLOAD_URL https://github.com/OWASP/O-Saft/archive/16.12.16.tar.gz
ENV DOWNLOAD_CHECKSUM 04fc94790421632f6b877a73a63b3cb03c7b0af45760b5e4d555687dea80d655
ENV DOWNLOAD_LOCATION /opt/osaft.tar.gz
ENV CHECKSUM_LOCATION /osaft-checksum

RUN wget $DOWNLOAD_URL -O $DOWNLOAD_LOCATION && \
  echo "$DOWNLOAD_CHECKSUM $DOWNLOAD_LOCATION" > $CHECKSUM_LOCATION && \
  RUN sha256sum --check $CHECKSUM_LOCATION || true && \
  cd /opt && tar -xzf $DOWNLOAD_LOCATION && \
  rm -f $DOWNLOAD_LOCATION && \
  mv /opt/* /opt/osaft

WORKDIR /opt/osaft

ENTRYPOINT ["perl", "/opt/osaft/o-saft.pl"]
