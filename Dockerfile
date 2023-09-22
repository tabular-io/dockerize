FROM golang:1.20.4 AS binary

WORKDIR /go/src/github.com/jwilder/dockerize
COPY *.go go.* /go/src/github.com/jwilder/dockerize/

ENV GO111MODULE=on
RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux GO111MODULE=on go build -a -o /go/bin/dockerize .

FROM alpine:latest

COPY --from=binary /go/bin/dockerize /bin/dockerize

USER 10001

ENTRYPOINT ["/bin/dockerize"]
CMD ["--help"]
