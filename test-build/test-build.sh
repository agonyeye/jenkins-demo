#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER} .
docker push 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER}
pwd
cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml

. /rancher-compose --url http://192.168.180.100:8080 --access-key 34A7CE5B9A9810A47582 --secret-key aoJPNdt8EbMaFbGWz7sr9CMZ1xvnnM8eEGUvNnEu -p python-redis-demo-build${BUILD_NUMBER} up -d
