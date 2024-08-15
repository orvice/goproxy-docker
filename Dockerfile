FROM golang:1.22 as builder

ARG ARG_GOPROXY
ENV GOPROXY $ARG_GOPROXY

WORKDIR /home/app
COPY go.mod go.sum ./

RUN go mod download

COPY . .
RUN go build -o /home/app/bin/goproxy main.go


FROM quay.io/orvice/go-runtime:latest

ENV PROJECT_NAME goproxy

COPY --from=builder /home/app/bin/${PROJECT_NAME} .
