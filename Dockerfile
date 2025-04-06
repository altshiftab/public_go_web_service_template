FROM golang:1.24-alpine AS builder

WORKDIR /usr/src/app
COPY . .
RUN go mod download && go mod verify

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags="-s -w" -installsuffix cgo -o /usr/src/bin/app

FROM scratch

COPY --from=builder /usr/src/bin/app .
USER 1000

ENTRYPOINT ["./app"]
