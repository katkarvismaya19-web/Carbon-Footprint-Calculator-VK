# Docker Lifecycle

## Build

docker build -t carbon-footprint-calculator:1.0 .

## Run

docker run -d --name carbon-footprint-calculator -p 8082:8080 carbon-footprint-calculator:1.0

## Check

docker ps

## Logs

docker logs carbon-footprint-calculator

## Stop

docker stop carbon-footprint-calculator

## Restart

docker start carbon-footprint-calculator

## Remove

docker rm -f carbon-footprint-calculator

## Image information

docker images carbon-footprint-calculator

## Application URL

http://localhost:8082/carbon-footprint-calculator/
