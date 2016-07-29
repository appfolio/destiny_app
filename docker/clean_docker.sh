docker rm $(docker ps -a -q)
blank_images=$(docker images | grep "^<none>" | awk '{print $3}')
echo $blank_images
docker rmi $blank_images
