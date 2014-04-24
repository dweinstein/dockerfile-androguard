all: build

build:
	docker build -t androguard .
	make -C data-container
run:
	-make -C data-container build
	-make -C data-container run
	docker run -t -i --rm --volumes-from androguard_data androguard
