.PHONY: fibonacci_number

fibonacci_number:
	docker build -t fibonacci_number .
	sleep 5
	docker run -d --name fibonacci_number -p 8080:8080 fibonacci_number

clean:
	docker stop fibonacci_number
	docker rm fibonacci_number

removeAll:
	docker system prune -a
