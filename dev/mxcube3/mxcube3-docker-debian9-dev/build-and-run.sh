echo "Build and run mxcube3 from the start"

echo "Remove previous mxcube3-dev container"
docker rm -f mxcube3-dev

echo "Build mxcube3-dev"
docker build --network=host -t mxcube3-dev .

# The following lines download mxcube3 source (if not present locally yet).
# mxcube3 folder will be mounted inside the final container:
echo "Clone mxcube (if needed)"
. debian-install.sh && mxcube_download

docker run -p 5901:5901 -p 8090:8090 --network=host -dt \
-v ${PWD}/mxcube3:/opt/mxcube3/ \
-v ${PWD}/docker-entrypoint.sh:/usr/local/bin/docker-entrypoint.sh:rw \
--name mxcube3-dev \
mxcube3-dev

echo " "
echo " "
echo "Done! Now enter container and start mxcube server with:"
echo " "
echo "\$ docker exec -it mxcube3-dev bash"
echo "\$ start-mxcube-server.sh"
