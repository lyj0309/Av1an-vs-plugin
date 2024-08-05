docker run --privileged -v "$(pwd):/videos" --user $(id -u):$(id -g) -it --rm av1:master -i script.py

