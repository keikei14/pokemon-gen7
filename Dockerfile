FROM golang:alpine AS builder
WORKDIR /build

COPY go.* ./
RUN go mod download

COPY . ./
RUN go build -v -o server

FROM alpine:latest AS runner
WORKDIR /app

COPY --from=builder /build/server /app/server
CMD ["/app/server"]