all: compose-setup

prepare:
	touch .bash_history
	touch .env

compose:
	docker-compose up

compose-install:
	docker-compose run web make install

compose-setup: prepare compose-build compose-install compose-db-setup

compose-db-setup:
	docker-compose run web make db-setup

compose-kill:
	docker-compose kill

compose-build:
	docker-compose build

compose-test:
	docker-compose run web make test

compose-bash:
	docker-compose run web bash

compose-lint:
	docker-compose run web make lint

start:
	NODE_ENV=development npx sequelize db:migrate \
		&& NODE_ENV=development DEBUG="application:*" npx nodemon --exec npx babel-node bin/index.js

compose-dist-build:
	rm -rf dist
	docker-compose run web npm run build

compose-publish: compose-dist-build
	docker-compose run web npm publish

install:
	npm install

db-setup:
	npx sequelize db:migrate

setup: prepare install db-setup

test:
	npm test

lint:
	npx eslint .

deploy:
	git push heroku

.PHONY: test
