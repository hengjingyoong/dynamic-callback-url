FROM golang:alpine
WORKDIR /go/src/app
COPY main.go .
RUN GOOS=linux go build -o main main.go
ENTRYPOINT /go/src/app/main