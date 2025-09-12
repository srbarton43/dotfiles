#!/usr/bin/env bash
# builds edk2 in a docker image

# name of edk2 build docker image
docker_img='edk2-build' 

#cmd basename
cmd="$(basename $0)"
build_script="$1"

echo "#######################"
echo "$cmd ($build_script): building edk2...."
echo "#######################"
pid=$(docker run --rm -t -d -w /app -v $(pwd):/app edk2-build &)
if [[ $# -eq 1 ]]; then
  docker exec "$pid" bash -c 'source edksetup.sh && build; exit $?'
else
  docker exec "$pid" bash -c 'source edksetup.sh && '"$build_script"'exit $?'
fi
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


