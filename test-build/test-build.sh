#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER} .
docker push 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER}
pwd
cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml

pwd
chmod 777 ./rancher-compose
./rancher-compose --url http://192.168.180.100:8080 --access-key F6E680E61B3FBA2FE465 --secret-key XntX4ocn5Ttxrt3nKVyqVdcrNDZC3pd2Jj31GcnA -p python-redis-demo-build${BUILD_NUMBER} up -d
