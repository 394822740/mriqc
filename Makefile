HOST=127.0.0.1
TEST_PATH=./
VERSION=0.0.3

clean-pyc:
		find . -name '__pycache__' -type d -exec rm -r {} +
		find . -name '*.pyc' -exec rm --force {} +
		find . -name '*.pyo' -exec rm --force {} +
		find . -name '*~' -exec rm --force  {} +

clean-build:
		rm --force --recursive build/
		rm --force --recursive dist/
		rm --force --recursive *.egg-info

lint:
		pylint ./mriqc/

test: clean-pyc
		py.test --verbose $(TEST_PATH)

dist: clean-build clean-pyc
		python setup.py sdist

docker-build:
		docker build \
			-f ./docker/Dockerfile_py27 \
			-t poldracklab/mriqc:$(VERSION)-python27 .
		docker build \
			-f ./docker/Dockerfile_py35 \
			-t poldracklab/mriqc:$(VERSION)-python35 .

docker-push:
		docker push poldracklab/mriqc:$(VERSION)-python27
		docker push poldracklab/mriqc:$(VERSION)-python35