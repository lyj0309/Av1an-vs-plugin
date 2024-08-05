docker build -t av1 .
docker run -v /ssd/data/:/videos -v "$(pwd):/pwd" --privileged  -it --rm av1

docker build -t av1test -f Dockerfile.test .
docker run -v /ssd/data/:/videos -v "$(pwd):/pwd" --privileged  -it --rm av1test

docker run --privileged  -it --rm masterofzen/av1an:master 
export PATH=$PATH:/home/app_user/.local/bin

av1an -i /pwd/script.py