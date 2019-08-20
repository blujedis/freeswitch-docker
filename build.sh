#!/bin/bash

docker build -t freeswitch-docker:1.10-latest . -f Dockerfile
FS_TMP=$(docker run --rm --entrypoint="" -it freeswitch-docker:1.10-latest /usr/bin/freeswitch -version 2> /dev/null)

echo ""
echo "========================================================================================"
echo $FS_TMP
echo "========================================================================================"

FS_VER=${FS_TMP:20:6}
FS_PARTS=(${FS_VER//./ })
FS_PARTS=(${FS_PARTS[@]})
FS_MAJOR_MINOR="${FS_PARTS[0]}.${FS_PARTS[1]}"

docker tag freeswitch-docker:1.10-latest blujedi/freeswitch-docker:${FS_VER}
docker tag freeswitch-docker:1.10-latest blujedi/freeswitch-docker:${FS_MAJOR_MINOR}
docker tag freeswitch-docker:1.10-latest blujedi/freeswitch-docker:1.10-latest

echo ""
echo "  Saved Tag \"blujedi/freeswitch-docker:${FS_VER}\""
echo "  Saved Tag \"blujedi/freeswitch-docker:${FS_MAJOR_MINOR}\""
echo ""
echo "----------------------------------------------------------------------------------------"
echo ""
