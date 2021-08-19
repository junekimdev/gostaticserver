#----- Builder -----
FROM golang:latest as builder

LABEL maintainer="June Kim"

WORKDIR /app

# install deps
COPY go.* ./
RUN go mod download

# copy all files and build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

#----- Deployer -----
FROM alpine:latest

LABEL maintainer="June Kim"

# install deps
# RUN set -eux \
#   && apk update \
#   && apk --no-cache add ca-certificates
# ca-certificates provides TLS/SSL in alpine

WORKDIR /root/

# copy executable from builder
COPY --from=builder /app/main .

VOLUME [ "/root/public" ]

# expose the port
EXPOSE 8080

# start
CMD ["./main"]
