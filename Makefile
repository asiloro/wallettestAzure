APP_NAME:=carteiropy
DOCKER_BASE_IMAGE_PYTHON:=python:3.8.3-alpine3.12
FOLDER:=env/bin/

all: build run-test 

# Application.: 

build:
	@echo "Building the Docker image of ${APP_NAME}"
	docker build -q -t ${APP_NAME} .

run: build
	@echo "Running ${APP_NAME} ..."
	docker run --rm -v $$(pwd)/output:/home/output --name ${APP_NAME} ${APP_NAME} main.py

run-code: build
	@echo "Running the code in this folder ..."
	docker run -it --rm -v $$(pwd):/app  -w /app  -u 1000 --name ${APP_NAME} ${APP_NAME} main.py

run-test:
	@echo "Testing the code in this folder ..."
	docker run --rm -v $$(pwd):/app -w /app --name ${APP_NAME} ${APP_NAME} pytest
# Debug.:

bash: build
	@echo "Open bash"
	docker run -it --rm -v $$(pwd):/app -w /app  --name ${APP_NAME} ${APP_NAME} sh

venv:
	@echo "Open python venv"
	$(FOLDER)/pip install -r ./requirements.txt
	$(FOLDER)/pip install -e .

pytest: venv
	@echo "Running pytest ..."
	$(FOLDER)/pytest
