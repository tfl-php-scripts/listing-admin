container=ladmin-php-apache

up:
	docker-compose up -d

down:
	docker-compose rm -vsf
	docker-compose down -v --remove-orphans

build:
	docker-compose rm -vsf
	docker-compose down -v --remove-orphans
	docker-compose build
	docker-compose up -d

build-clean:
	docker-compose rm -vsf
	docker-compose down -v --remove-orphans
	docker-compose build
	docker-compose -f docker-compose.yml -f docker-compose-clean.yml up -d

jumpin:
	docker exec -ti ${container} bash

logs:
	docker-compose logs -f

phpstan:
	docker exec -ti ${container} composer install
	docker exec -ti ${container} php vendor/bin/phpstan analyse --memory-limit 1G --debug

phpstan-baseline:
	docker exec -ti ${container} composer install
	docker exec -ti ${container} php vendor/bin/phpstan analyse --memory-limit 1G --debug --generate-baseline

rector:
	docker exec -ti ${container} composer install
	docker exec -ti ${container} php vendor/bin/rector process --dry-run --debug

rector-update:
	docker exec -ti ${container} composer install
	docker exec -ti ${container} php vendor/bin/rector process --debug
