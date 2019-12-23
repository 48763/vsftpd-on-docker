FROM alpine:3.10

LABEL maintainer="Yuki git@48763 <future.starshine@gmail.com>"

RUN set -x \
    && tempDir="$(mktemp -d)" \
    && cd ${tempDir} \
    && apk add --no-cache \
        vsftpd \
        linux-pam \
        openssl \
    && mkdir /data \
    && chown ftp:ftp /data \
    && wget https://github.com/tiwe-de/libpam-pwdfile/archive/v1.0.tar.gz \
    && tar -xvf v1.0.tar.gz \
    && cd libpam-pwdfile-1.0 \
    && apk add --no-cache --virtual .build-deps \
        make \
        gcc \
        linux-pam-dev \
        libc-dev \
    && make \
    && make install \
    && mv pam_pwdfile.so /lib/security \
    && cd ${tempDir}/.. \
    && rm -rf ${tempDir} \
    && apk del .build-deps

WORKDIR /etc/vsftpd

COPY ["vsftpd.virtual", "/etc/pam.d/"]
COPY ["addftpuser", "vsftpd.conf", "run", "/etc/vsftpd/"]

CMD ["sh", "run", "vsftpd", "vsftpd.conf"]