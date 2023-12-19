@echo off
Setlocal Enabledelayedexpansion
(for %%i in (*.jar) do (set str=%%i ))
md gclog
java -server -Xloggc:gclog/gc.log -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=8 -XX:GCLogFileSize=64m -Dlogging.config=config/logback-spring.xml -jar %str%