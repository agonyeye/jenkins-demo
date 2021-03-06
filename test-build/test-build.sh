#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER} .
docker push 192.168.180.100:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml

sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key EF156F5D22D46A81D9B0 --secret-key QMGwZjWJqNaV8F7aiETmzWRo6zJnarBBKzSzUJoh -p python-redis-demo-build${BUILD_NUMBER} up -d
