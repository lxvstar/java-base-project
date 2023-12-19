#!/bin/bash
echo "docker run......"
docker run -p 17183:7183 -d -v /admin/customApp/client/application-dev.yml:/custom/service/config/application-dev.yml \
-v /admin/customApp/client/client.jar:/custom/service/lib/client.jar \
-v /etc/localtime:/etc/localtime:ro \
--name client client:1.0
