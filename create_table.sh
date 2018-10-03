#!/bin/bash

touch data_table.txt

ulimit -n 25000
concurrency=(50 100 500 1000 2000 5000 10000 15000)
requests=(10000 10000 10000 10000 10000 20000 30000 45000)

printf "%s ----Parsing information to data_table.txt----"

awk 'BEGIN { printf "%-16s %-14s %-30s %-20s %-14s\n", "Concurrency", "Requests", 
"Requests per second (mean)", "Longest request", "98 percentile"}' >> data_table.txt

for(( j=0; j <= 7; j=j+1 )); do
	printf "%-16s %-15s" ${concurrency[j]} ${requests[j]} >> data_table.txt
	ab -q -p payload.json -T application/json -m POST -n ${requests[j]} -c ${concurrency[j]} -s 100 -r http://35.203.140.61:8080/fibonacci \
		| awk ' /Requests/ {printf "%-31s", $4} /100%/ {printf "%-30s", $2} /98%/ {printf "%-21s", $2}' >> data_table.txt
	printf "%s \n" >> data_table.txt
done

printf "%s \n ----Operation Complete---- \n"
