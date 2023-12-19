FROM centos

RUN mkdir -p /admin /custom/service /custom/jre && chmod 777 /admin -R && chmod 777 /custom && echo "Asia/Dubai" > /etc/timezone

COPY image /custom/service
COPY jre /custom/jre

EXPOSE 17183
ENTRYPOINT /custom/service/start.sh
