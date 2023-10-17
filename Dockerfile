FROM golang:1.15.0-alpine3.12 AS builder

ENV GO111MODULE on
ENV GOPROXY https://goproxy.cn

RUN apk upgrade \
    && apk add git \
    && go get github.com/darren2046/go-shadowsocks2

FROM alpine:3.12 AS dist

RUN apk upgrade \
    && apk add tzdata \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/go-shadowsocks2 /usr/bin/shadowsocks

CMD ["shadowsocks"]
