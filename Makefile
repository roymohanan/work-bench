.PHONY: all

all: clean-all build-all
build-all: build-base build-vim build-py build-devops
clean-all: clean-base clean-vim clean-py clean-devops

USER := $(shell whoami)
AWS_SECRET_ACCESS_KEY := $(shell grep -A 4 'aws_dev' ~/.aws/credentials | grep aws_secret_access_key| cut -d ' ' -f 3)
AWS_ACCESS_KEY_ID := $(shell grep -A 4 'aws_dev' ~/.aws/credentials | grep aws_access_key_id | cut -d ' ' -f 3)
AWS_DEFAULT_REGION := $(shell grep -A 4 'aws_dev' ~/.aws/credentials | grep region | cut -d ' ' -f 3)

clean-base:
	if [ "$$(docker images -q dev-base)" ]; then \
		docker rmi -f dev-base; \
	fi

clean-vim:
	if [ "$$(docker images -q dev-vim)" ]; then \
		docker rmi -f dev-vim; \
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
		docker build -t dev-base --build-arg user=$(USER) -f Dockerfile .

build-vim: build-base
	cd dev-vim &&\
	docker build -t dev-vim --build-arg user=$(USER) -f Dockerfile .

build-py: build-vim
	cd dev-py &&\
	docker build -t dev-py --build-arg user=$(USER) -f Dockerfile .

build-devops:
	cd dev-devops &&\
	docker build -t dev-devops \
		--build-arg user=$(USER)  \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION)\
		-f Dockerfile .

run-py:
	docker run -it -v /home/roy/dev/:/home/$(USER)/dev/ dev-py

run-devops:
	docker run -it -v /home/roy/dev/:/home/$(USER)/dev/ dev-devops

