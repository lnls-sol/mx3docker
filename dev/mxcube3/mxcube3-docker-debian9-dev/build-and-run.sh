echo "Build and run mxcube3 from the start"

#docker rm -f mxcube3-base
docker rm -f mxcube3-dev

#./build-base.sh
#./build-dev.sh
#./run-dev.sh

docker build --network=host -t mxcube3-dev .

#docker run -p 5901:5901 -p 8090:8090 --network=host -dt \
#-v $HOME/.Xauthority:/home/${USER}/.Xauthority:rw \
#-e DISPLAY -e QT_X11_NO_MITSHM=1 \
#--name mxcube3-dev \
#mxcube3-dev

docker run -p 5901:5901 -p 8090:8090 --network=host -dt \
--name mxcube3-dev \
mxcube3-dev

# Enter container:
#docker exec -it mxcube3-dev bash
