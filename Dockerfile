FROM php:alpine
MAINTAINER mdsami <mdsami.diu@gmail.com>

RUN apk update && apk upgrade && apk add bash git

# Install PHP extensions
ADD php-installer.sh /usr/sbin/php-installer.sh
RUN /usr/sbin/php-installer.sh


# Install Mongo

FROM alpine:edge

RUN \
apk add --no-cache mongodb && \
rm /usr/bin/mongoperf

VOLUME /data/db
EXPOSE 27017 28017

COPY mongo-installer.sh /root
ENTRYPOINT [ "/root/mongo-installer.sh" ]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]


FROM alpine
RUN apk --no-cache add nginx
COPY nginx.conf /etc/nginx/
RUN mkdir -p /run/nginx
CMD ["nginx"]


# Download and install NodeJS

ENV NODE_VERSION 10.1.0
ADD node-installer.sh /usr/sbin/node-installer.sh
RUN /usr/sbin/node-installer.sh
RUN npm i -g yarn

RUN mkdir -p /etc/ssl/certs && update-ca-certificates

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1