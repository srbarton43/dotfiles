#!/usr/bin/env bash
cmd='build.sh'

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


