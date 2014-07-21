all: build

build:
	docker build -t androguard-data .
run: clean
	-docker run --name androguard_data androguard-data &> /dev/null
clean:
	-docker stop androguard_data &> /dev/null
	-docker rm androguard_data &> /dev/null
