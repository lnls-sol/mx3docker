echo "Build and run mxcube3 from the start"

echo "Remove previous mxcube3-dev container"
docker rm -f mxcube3-dev

echo "Build mxcube3-dev"
docker build --network=host -t mxcube3-dev .

# Uncomment here to download mxcube3 source (if not present locally yet).
# mxcube3 folder will be mounted inside the final container.
#echo "Clone mxcube"
#. debian-install.sh && mxcube_download
# cd ..

docker run -p 5901:5901 -p 8090:8090 --network=host -dt \
-v ${PWD}/mxcube3:/opt/mxcube3 \
--name mxcube3-dev \
mxcube3-dev

# Enter container and then start mxcube server:
#docker exec -it mxcube3-dev bash
#start-mxcube-server.sh
