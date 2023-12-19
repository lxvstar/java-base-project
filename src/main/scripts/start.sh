#!/bin/bash
BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF_DIR=/custom/service/config
LIB_DIR=/custom/service/lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`
JAVA_OPTS=" -Djava.net.preferIPv4Stack=true -Dfile.encoding=utf-8"
JAVA_MEM_OPTS=" -server -Xms1g -Xmx2g -XX:SurvivorRatio=2 -XX:+UseParallelGC "

BINMAIN=com.sensetime.jv.StartApplication
START_CMD="/custom/jre/bin/java $JAVA_OPTS $JAVA_MEM_OPTS -classpath $CONF_DIR:$LIB_JARS $BINMAIN"
STOP_CMD="kill $PID"
$START_CMD