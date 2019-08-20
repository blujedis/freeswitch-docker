#!/bin/bash

if [ "${1}" == "-b" ] || [ "${1}" == "--build" ]
then
  ./build.sh
else
   echo "To build before 'docker run' use -b or --build"
fi

docker run --rm -it --name fs1 -e "FS_XMLRPC_PORT=8081" -p 7443:7443  -p 7480:7480 -p 5060:5060 -p 5061:5061 -p 8081:8081 -p 8020:8020 freeswitch-docker:latest

