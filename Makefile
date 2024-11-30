
.PHONY: up down bash root-bash

# Load environment variables
include .env
$(eval export $(shell sed -ne 's/ *#.*$$//; /./ s/=.*$$// p' .env))

up:
	docker-compose -f deploy/local/docker-compose.yml up --build 

down:
	docker-compose -f deploy/local/docker-compose.yml down

bash:
	$(MAKE) load-env
	docker-compose -f deploy/local/docker-compose.yml exec -u www-data web bash

root-bash:
	docker-compose -f deploy/local/docker-compose.yml exec -u root web bash
