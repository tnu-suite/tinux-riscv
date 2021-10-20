DOCKER_NAME ?= techzealot/tinux-riscv
.PHONY: docker build-docker run build

docker:
	docker run --rm -it --mount type=bind,source=$(shell pwd),destination=/mnt -w /mnt ${DOCKER_NAME}

build-docker:
	docker build -t ${DOCKER_NAME} .

run:
	cd os;cargo run;echo $$?;

build:
	cd os;cargo build

