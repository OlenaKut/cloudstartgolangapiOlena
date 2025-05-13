FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git
WORKDIR /app
COPY . .

RUN go get -d -v
RUN go test ./...
RUN go build -o /app/site

FROM scratch

COPY --from=builder /app/cmd/site /site
COPY *.yml /

EXPOSE 8080
ENTRYPOINT ["/site"]