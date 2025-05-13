FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /app

# Copy Go modules first for better build caching
COPY go.mod go.sum ./
RUN go mod download

# Now copy the rest of the project
COPY . .

# Build binary
RUN go build -o /app/site

RUN go test -v

# Final image
FROM alpine

WORKDIR /app

# Copy built binary and static files
COPY --from=builder /app/site /site
COPY --from=builder /app/static ./static

EXPOSE 8080
ENTRYPOINT ["/site"]
