FROM alpine:latest

LABEL maintainer="Christoph Wiechert <wio@psitrax.de>" \
  CONTRIBUTORS="Mathias Kaufmann <me@stei.gr>"

ENV REFRESHED_AT="2019-11-16" \
  POWERDNS_VERSION=4.2.0 \
  AUTOCONF=mysql \
  MYSQL_HOST="mysql" \
  MYSQL_PORT="3306" \
  MYSQL_USER="root" \
  MYSQL_PASS="root" \
  MYSQL_DB="pdns" \
  PGSQL_HOST="pgsql" \
  PGSQL_PORT="5432" \
  PGSQL_USER="postgres" \
  PGSQL_PASS="postgres" \
  PGSQL_DB="pdns" \
  SQLITE_DB="pdns.sqlite3"

RUN set -ex; \
  apk --update add \
    libpq \
    libstdc++ \
    libgcc \
    mariadb-connector-c-dev \
    mysql-client \
    postgresql-client \
    sqlite \
    sqlite-libs \
  apk add --virtual .build-deps \
    binutils \
    boost-dev \
    curl \
    file \
    g++ \
    make \
    mariadb-dev \
    postgresql-dev \
    sqlite-dev \
  ; \
  curl -sSL https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xj -C /tmp; \
  cd /tmp/pdns-$POWERDNS_VERSION; \
  ./configure \
    --prefix="" \
    --exec-prefix=/usr \
    --sysconfdir=/etc/pdns \
    --with-modules="" \
    --with-dynmodules="bind gmysql gpgsql gsqlite3" \
    --disable-lua-records \
  ; \
  make; \
  make install-strip; \
  cd /; \
  mkdir -p /etc/pdns/conf.d; \
  addgroup -S pdns 2>/dev/null; \
  adduser -S -D -H -h /var/empty -s /bin/false -G pdns -g pdns pdns 2>/dev/null; \
  apk del --purge .build-deps; \
  rm -rf /tmp/* /var/cache/apk/* /root/.cache ;

ADD sql/* pdns.conf /etc/pdns/
ADD entrypoint.sh /

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/entrypoint.sh"]
