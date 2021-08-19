.PHONY: all build bf update up down clean

all: build

NAME=gostatic
TAG=1.0-alpine

build:
	docker build \
	-t junekimdev/$(NAME):$(TAG) .

# build without using cache
bf:
	docker build \
	--no-cache \
	-t junekimdev/$(NAME):$(TAG) .

# This updates local repo
update:
	@[ -d .git ] \
	&& git fetch --all && git reset --hard origin/master \
	|| echo "Git repo does not exist. Clone it first."

up:
	@docker-compose up -d \
	&& sleep 5 \
	&& docker logs -t --tail 5 $(NAME)

down:
	docker-compose down -v

clean:
	docker rmi $(shell docker images -qf dangling=true)