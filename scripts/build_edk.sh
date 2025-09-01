#!/usr/bin/env bash
# builds edk2 in a docker image

# name of edk2 build docker image
docker_img='edk2-build' 

#cmd basename
cmd="$(basename $0)"

echo "#######################"
echo "$cmd: building edk2...."
echo "#######################"
pid=$(docker run --rm -t -d -w /app -v $(pwd):/app edk2-build &)
docker exec "$pid" bash -c 'source edksetup.sh && build; exit $?'
ret=$?
docker kill "$pid" 2&> /dev/null
if [[ $ret -eq 0 ]]; then
  echo "#######################"
  echo "$cmd: done building...."
  echo "#######################"
else
  echo "############################"
  echo "$cmd: error during build...."
  echo "############################"
fi


