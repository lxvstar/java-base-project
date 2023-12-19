#!/bin/bash
################################################################################
#  1.此程序启动脚本要求项目打包后的结构为：
#			XXXX.jar
#			/config
#			/lib
#			service-cli.sh
#		或者为
#			XXXX.jar（所有类打在同一个包中）
#			/config
#			service-cli.sh
#  2.确保service-cli.sh同级目录中，仅有一个以jar结尾的包。
#  3.JVM的环境变量获取规则为
#		1）首先获取脚本中JAVA_HOME_TOOLS的路径，不存在的话，会使用JAVA_HOME的路径。
#		2）JAVA_HOME_TOOLS与JAVA_HOME都未设置，则报错。
#-------------CopyRight-------------  
#   Name:程序启动脚本  
#   Version Number:1.00    
#   Language:bash shell  
#   Date:2020-07-07  
#   Author:陶瑞成  
#   Email:taoruicheng@sensetime.com  
################################################################################

JAVA_HOME_TOOLS="/admin/customApp/tools/jdk1.8.0_251"
MONITOR_INTERVAL=120
JVM_Xms=2048m
JVM_Xmx=10240m

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $BIN_DIR
MAIN_JAR="$(ls ./ | grep -m1  '.jar$')"

if [ ! -d system-info  ];then
  mkdir system-info
fi
cd system-info

MONITOR_LOG="$BIN_DIR/system-info/monitor.log"
MONITOR_PIDFILE="$BIN_DIR/system-info/monitor.pid"
MONITOR_PID=0
if [[ -f $MONITOR_PIDFILE ]]; then
  MONITOR_PID=`cat $MONITOR_PIDFILE`
fi

if [ ! -d gclog  ];then
  mkdir gclog
fi

PIDFILE="$BIN_DIR/system-info/$(basename $MAIN_JAR).pid"
PID=0
if [[ -f $PIDFILE ]]; then
  PID=`cat $PIDFILE`
fi

STOP_CMD="kill $PID"

cd  ..

running() {
  if [[ -z $1 || $1 == 0 ]]; then
      echo 0
      return
  fi
  if [[ -d /proc/$1 ]]; then
      echo 1
      return
  fi
  echo 0
  return
}

start_app() {
  if [[ $(running $PID) == 1 ]]; then
	echo "$(date '+%Y-%m-%d %T') 【start】:程序$MAIN_JAR已经启动，无需启动,PID为：$PID" >> $MONITOR_LOG
	return 2
  fi

  nohup $JAVA_HOME_TOOLS -server -Dfile.encoding=UTF-8 -Xms${JVM_Xms} -Xmx${JVM_Xmx} -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:./system-info/gclog/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=8 -XX:GCLogFileSize=64m -Dspring.config.location=./config/ -jar ${MAIN_JAR}  >> /dev/null 2>&1 &
  PID=$!
  sleep 4
  if [[ $(running ${PID}) == 0 ]]; then
    echo "$(date '+%Y-%m-%d %T') 【ERROR】:启动程序$MAIN_JAR 失败!!!!!!PID:${PID}" >> $MONITOR_LOG
    return 1
  fi
  echo $PID > $PIDFILE
  echo "$(date '+%Y-%m-%d %T') 【start】:启动成功,程序${MAIN_JAR}的PID为：$PID" >> $MONITOR_LOG
  return 0
}
test_app() {
   if [[ $(running $PID) == 1 ]]; then
	 echo "【test】:程序$MAIN_JAR已经启动，无需启动,PID为：$PID"
	 echo "$(date '+%Y-%m-%d %T') 【test】:程序$MAIN_JAR已经启动，无需启动,PID为：$PID" >> $MONITOR_LOG
	 exit 1
   fi
   checkJVMPath
   if [ $? == 1 ]; then
       exit 1
   fi
   checkJAR
   if [ $? == 1 ]; then
      exit 1
   fi

  nohup $JAVA_HOME_TOOLS -server -Dfile.encoding=UTF-8 -Xms${JVM_Xms} -Xmx${JVM_Xmx} -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:./system-info/gclog/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=8 -XX:GCLogFileSize=64m -Dspring.config.location=./config/ -jar ${MAIN_JAR}  &
  PID=$!
  sleep 4
  if [[ $(running ${PID}) == 0 ]]; then
    echo "【ERROR】:启动程序$MAIN_JAR 失败，请查看nohup.out日志!!!!!!PID:${PID}"
    echo "$(date '+%Y-%m-%d %T') 【ERROR】:启动程序$MAIN_JAR 失败，请查看nohup.out日志!!!!!!PID:${PID}" >> $MONITOR_LOG
    exit 1
  fi
  echo $PID > $PIDFILE
  echo "【test】:启动成功,程序${MAIN_JAR}的PID为：${PID}"
  echo "$(date '+%Y-%m-%d %T') 【test】:启动成功,程序${MAIN_JAR}的PID为：${PID}" >> $MONITOR_LOG
}

stop_app() {
  if [[ $(running $PID) == 0 ]]; then
    return
  fi
  echo "【stop】:停止程序$MAIN_JAR，PID为: $PID "
  echo "$(date '+%Y-%m-%d %T') 【stop】:停止程序$MAIN_JAR，PID为: $PID " >> $MONITOR_LOG
  $STOP_CMD
  sleep 1
  $STOP_CMD
  sleep 1
  $STOP_CMD
}

checkJVMPath() {
    if [[ -d "${JAVA_HOME_TOOLS}/" ]]; then
      echo   "【check JVM】:JVM环境变量地址使用的为JAVA_HOME_TOOLS设置的变量：$JAVA_HOME_TOOLS"
      JAVA_HOME_TOOLS="$JAVA_HOME_TOOLS"/bin/java
      return 0
    fi
    if [ $JAVA_HOME ]; then
      echo   "【check JVM】:JVM环境变量地址为：$JAVA_HOME"
      JAVA_HOME_TOOLS="$JAVA_HOME"/bin/java
      return 0
    else
      $(java -version)
      if [ $? -ne 0 ]; then
        echo "【ERROR】:设置的JAVA_HOME_TOOLS目录${JAVA_HOME_TOOLS}不存在，请在环境变量中设置JAVA_HOME变量或者设置service-cli.sh中的JAVA_HOME_TOOLS为正确的java home 路径"
        return 1
      else
        JAVA_HOME_TOOLS="java"
        echo "直接使用不带路径的java命令执行"
        return 0
      fi
    fi
}

checkJAR(){
  if [[ ${#MAIN_JAR}  == 0 ]]; then
    echo "【check JAR】:在当前目录下未搜索到.jar结尾的jar包，请把要启动的jar包放在本目录。"
    return 1
  else
    echo "【check JAR】:要启动的jar为：${MAIN_JAR}"
    return 0
  fi
}

start_monitor() {
  if [[ $(running $MONITOR_PID) == 1 ]]; then
    echo "【start monitor】:监控程序已经启动，无需再次启动。监控程序的PID为$MONITOR_PID"
    return
  fi
  while [ 1 ]; do
    if [[ $(running $PID) == 0 ]]; then
      echo "$(date '+%Y-%m-%d %T') 【start monitor】:================监控到$MAIN_JAR 未启动 ,开始启动================" >> $MONITOR_LOG
      start_app
      echo "$(date '+%Y-%m-%d %T') 【start monitor】:=======================$MAIN_JAR 启动成功=======================" >> $MONITOR_LOG
	else
      echo "$(date '+%Y-%m-%d %T') 【start monitor】:监控到$MAIN_JAR 运行正常"  >> $MONITOR_LOG
    fi
    sleep $MONITOR_INTERVAL
  done &
  MONITOR_PID=$!
  echo "【start monitor】:监控程序已经启动，监控间隔为${MONITOR_INTERVAL}秒，监控程序的PID为$!"
  echo "$(date '+%Y-%m-%d %T') 【start monitor】:监控程序已经启动，监控间隔为${MONITOR_INTERVAL}秒，监控程序的PID为$!"  >> $MONITOR_LOG
  echo $! > $MONITOR_PIDFILE
}

stop_monitor() {
  if [[ $(running $MONITOR_PID) == 0 ]]; then
    echo "【stop monitor】:监控程序已经停止"
    return
  fi
  echo "【stop monitor】:停止监控程序。PID:$MONITOR_PID "
  echo "$(date '+%Y-%m-%d %T') 【stop monitor】:停止监控程序。PID:$MONITOR_PID"  >> $MONITOR_LOG
  kill $MONITOR_PID
  sleep 1
  kill $MONITOR_PID
  sleep 1
  kill $MONITOR_PID
}
status_app(){
    if [[ $(running $PID) == 1 ]]; then
        echo "【运行中】:程序$MAIN_JAR正在运行中，PID为：$PID"
    else
        echo "【停止运行】:程序$MAIN_JAR已经停止运行"
    fi
    if [[ $(running $MONITOR_PID) == 1 ]]; then
        echo "【运行中】:监控程序正在运行中，PID为：$MONITOR_PID"
    else
        echo "【停止运行】:监控程序已经停止运行"
    fi
}
start() {
   checkJVMPath
   if [ $? == 1 ]; then
       exit 1
   fi
   checkJAR
   if [ $? == 1 ]; then
      exit 1
   fi
  start_app
  if [ $? == 1 ]; then
      echo "【ERROR】:启动程序$MAIN_JAR 失败,请检查错误日志或者尝试使用./service-cli.sh test 进行测试!!!!!!"
      exit 1
  fi
  if [ $? == 2 ]; then
      echo "【WARN】:程序$MAIN_JAR 已经启动，请勿重复启动！！！"
      exit 1
  fi
  echo "【start jar】:程序${MAIN_JAR}启动成功。"

  start_monitor
}

stop() {
  stop_monitor
  stop_app
}

restart() {
  stop
  start
}
help() {
  echo "
--------------------------------------脚本说明---------------------------------------------	
#  1.此程序启动脚本要求项目打包后的结构为：
#	  XXXX.jar
#	  /config
#	  /lib
#	  service-cli.sh
#	 或者为
#	  XXXX.jar（所有类打在同一个包中）
#	  /config
#	  service-cli.sh
#  2.确保service-cli.sh同级目录中，仅有一个以jar结尾的包。
#  3.JVM的环境变量:
#	  1）首先获取本脚本中JAVA_HOME_TOOLS的路径，不存在的话，会使用JAVA_HOME的路径。
#	  2）JAVA_HOME_TOOLS与JAVA_HOME都未设置，则检查是否可以直接用java命令启动，否则报错。
#  4.当遇到JVM内存不足的情况，调整此脚本的JVM_Xmx变量来设置JVM占用的最大内存；调整JVM_Xms变量来设置JVM占用的最小内存
#  5.垃圾回收算法使用的UseConcMarkSweepGC算法，如有需要，请修改。
-----------------------------------------------------------------------------------------
  "
}

case "$1" in
start)
  start
  ;;
stop)
  stop
  ;;
test)
  test_app
  ;;
help)
  help
  ;;
restart)
  stop
  start
  ;;
status)
  status_app
  ;;
*)
  echo "------------------------------------程序操作命令----------------------------------------
    1）./service-cli.sh start：启动程序
    2）./service-cli.sh stop：停止程序
    3）./service-cli.sh restart：重启程序
    4）./service-cli.sh test：测试程序是否正常启动，错误日志输出到当前文件夹下的nohup.out文件中；
		测试成功后，需要再执行./service-cli.sh restart来重启程序开启守护进程。
    5）./service-cli.sh status：查看程序运行状态。
    6）./service-cli.sh help：查看脚本说明。
--------------------------------------------------------------------------------------------
	"
  exit 0
esac
