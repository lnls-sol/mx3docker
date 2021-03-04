echo "Build and run mxcube3 from the start"

echo " "
echo "Remove previous mxcube3-dev-lnls container"
echo " "
podman rm mxcube3-dev-lnls

echo " "
echo "Build mxcube3-dev-lnls"
echo " "
podman build --network=host -t mxcube3-dev-lnls .

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


podman run -p 5901:5901 -p 8090:8090 --network=host -dt \
-v ${PWD}/mxcube3:/opt/mxcube3/ \
-v ${PWD}/docker-entrypoint.sh:/usr/local/bin/docker-entrypoint.sh:rw \
-v /ibira/sirius/beamlines/manaca/:/ibira/sirius/beamlines/manaca/ \
-v /usr/local/sol/:/usr/local/sol/
-v /usr/local/setup-bl:/usr/local/setup-bl
-v /usr/local/sol-nfs:/usr/local/sol-nfs
--privileged \
--name mxcube3-dev-lnls \
mxcube3-dev-lnls

echo " "
echo " "
echo "Done! Now enter container and start mxcube server with:"
echo " "
echo "\$ podman exec -it mxcube3-dev-lnls bash"
echo "\$ start-mxcube-server.sh"
