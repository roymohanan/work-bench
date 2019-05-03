.PHONY: all

all: clean-all build-all
build-all: build-base build-vim build-py  build-node build-devops
clean-all: clean-base clean-vim clean-py clean-node clean-devops

USER := $(shell whoami)

clean-base:
	if [ "$$(docker images -q dev-base)" ]; then \
		docker rmi -f dev-base; \
	fi

clean-vim:
	if [ "$$(docker images -q dev-vim)" ]; then \
		docker rmi -f dev-vim; \
	fi

clean-node:
	if [ "$$(docker images -q dev-node)" ]; then \
		docker rmi -f dev-node; \
	fi

clean-py:
	if [ "$$(docker images -q dev-py)" ]; then \
		docker rmi -f dev-py; \
	fi

clean-devops:
	if [ "$$(docker images -q dev-devops)" ]; then \
		docker rmi -f dev-devops; \
	fi

build-base:
	cd dev-base &&\
	docker build --no-cache -t dev-base --build-arg user=$(USER) -f Dockerfile .

build-vim: build-base
	cd dev-vim &&\
	docker build --no-cache -t dev-vim --build-arg user=$(USER) -f Dockerfile .

build-py: build-vim
	cd dev-py &&\
	docker build -t dev-py --build-arg user=$(USER) -f Dockerfile .

build-node: build-py
	cd dev-node &&\
	docker build --no-cache -t dev-node --build-arg user=$(USER) -f Dockerfile .

build-devops: build-node
	cd dev-devops &&\
	docker build -t dev-devops \
		--build-arg user=$(USER)  \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) \
		-f Dockerfile .

run-vim:
	docker run -it -v /home/roy/:/home/$(USER)/mnt dev-vim

run-py:
	docker run -it -v /home/roy/dev/:/home/$(USER)/dev/ dev-py

run-devops:
	docker run -it -v /home/roy/dev/:/home/$(USER)/dev/ dev-devops

run-node:
	docker run -it -v /home/roy/dev/:/home/$(USER)/dev/ dev-node
