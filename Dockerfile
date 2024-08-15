FROM golang:1.22 as builder

ARG ARG_GOPROXY
ENV GOPROXY $ARG_GOPROXY

WORKDIR /home/app
COPY go.mod go.sum ./

RUN go mod download

COPY . .
ENV CGO_ENABLED=0
RUN go build -o /home/app/bin/goproxy ./cmd/main.go


FROM golang:1.23

ENV PROJECT_NAME goproxy
WORKDIR /app/bin

COPY --from=builder /home/app/bin/${PROJECT_NAME} /app/bin/goproxy

ENTRYPOINT [ "/app/bin/goproxy" ]