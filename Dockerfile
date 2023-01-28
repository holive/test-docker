FROM golang:1.18-alpine AS builder

WORKDIR /app

COPY *.go ./

RUN go env -w GO111MODULE=off
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o main

FROM scratch
WORKDIR /app
COPY --from=builder /app/main .
ENTRYPOINT ["./main"]
