# Common docker commands:
#   docker build -t SOME_IMAGE_AND_TAG_HERE .
#       - builds a new image and gives it the provided tag
#       - The period specifies that it should look for the Dockerfile in this directory
#   docker run -it SOME_IMAGE_AND_TAG_HERE
#       - spins up a container for the image/tag provided
#       - ``-it`` drops you into the container immediately
#   docker ps
#       - lists out all the containers you've created / have running
#   docker images
#       - lists out all the images you've created
#   docker rmi SOME_IMAGE_ID_HERE
#       - removes an image you've created

FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Install dependencies
COPY ./setup.cfg $WORKDIR
COPY ./pyproject.toml $WORKDIR
RUN pip install -e .[test]

# Copy code into the folder
COPY . /app

# Start running in a bash session
ENTRYPOINT [ "/bin/bash" ]
