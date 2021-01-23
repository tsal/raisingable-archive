FROM golang:1.15-alpine AS build
ENV HUGO_VERSION=0.80.0
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
ARG HUGO_ENV
ENV HUGO_ENV=${HUGO_ENV:-production}
ENV CASTANET_VERSION=1.14.1
RUN wget -O - https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz | tar -xz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md
RUN apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates
ADD . /src
WORKDIR /src
RUN wget -O /tmp/castanet.zip https://github.com/mattstratton/castanet/releases/download/$CASTANET_VERSION/castanet-$CASTANET_VERSION.zip
RUN unzip /tmp/castanet.zip -d themes/
RUN hugo -e $HUGO_ENV

FROM nginx:alpine
WORKDIR /public
COPY --from=build /src/public /usr/share/nginx/html
