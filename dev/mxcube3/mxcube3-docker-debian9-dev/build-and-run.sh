echo "Build and run mxcube3 from the start"

echo " "
echo "Remove previous mxcube3-dev-lnls container"
echo " "
docker rm -f mxcube3-dev-lnls

echo " "
echo "Build mxcube3-dev-lnls"
echo " "
docker build --network=host -t mxcube3-dev-lnls .

# The following lines download mxcube3 source in the current folder (if not
# present locally yet).
# mxcube3 folder will be mounted inside the final container.
if [ -d "mxcube3" ]; then
  echo " "
  echo "Mxcube3 folder exists. Skip clone."
  echo " "
else
  echo " "
  echo "Mxcube3 folder do not exist. Clone mxcube3."
  echo " "
  . debian-install.sh && mxcube_download
fi


docker run -p 5901:5901 -p 8090:8090 --network=host -dt \
-v ${PWD}/mxcube3:/opt/mxcube3/ \
-v ${PWD}/docker-entrypoint.sh:/usr/local/bin/docker-entrypoint.sh:rw \
--privileged \
--name mxcube3-dev-lnls \
mxcube3-dev-lnls

echo " "
echo " "
echo "Done! Now enter container and start mxcube server with:"
echo " "
echo "\$ docker exec -it mxcube3-dev-lnls bash"
echo "\$ start-mxcube-server.sh"
