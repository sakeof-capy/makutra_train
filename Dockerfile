FROM rust:1.80-alpine3.19 as builder

WORKDIR /usr/src/makutra/makutra_train

COPY . .

RUN apk upgrade --update-cache --available && \
    apk add --no-cache pkgconfig musl-dev gcc build-base openssl-libs-static openssl-dev && \
    rm -rf /var/cache/apk/* && \
    cargo build --release

FROM alpine:3.19

COPY --from=builder /usr/src/makutra/makutra_train/target/release/makutra_train /usr/local/bin/makutra_train

CMD ["makutra_train"]