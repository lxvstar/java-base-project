#!/bin/bash
docker save > image-1.0.0.tar client:1.0 && tar -zcvf client.tar.gz client.tar
