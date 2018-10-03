FROM golang:alpine
COPY src/fibonacci_number.go src/
WORKDIR src/
CMD ["go", "run", "fibonacci_number.go"]
