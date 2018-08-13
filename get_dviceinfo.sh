#!/bin/sh
################################################################################
#author:cprime
#date:2012/08/20
#filename:get_deviceinfo.sh
#get device infomations
################################################################################
#install tools for getting device infomations 
#yum install -y dmidecode lshw
BOARD_FIRM_NAME=`dmidecode -t 2 | awk -F':' '/Manu/{print $2}'`
BOARD_TYPE=`dmidecode -t 2 | awk -F':' '/Product/{print $2}'`
BOARD_SERIAL=`dmidecode -t 2 | awk -F':' '/Serial/{print $2}'`

CPU_MODEL=`cat /proc/cpuinfo | awk -F':' '/model name/{print $2}' | sed -n '1p'`
CPU_KENAL_NUM=`cat /proc/cpuinfo | awk -F':' '/model name/{print $2}' | wc -l`

MEM_PRODUCKT=`dmidecode -t 17 | sed -e '/./{H;$!d}' -e 'x;/Rank: 2/!d' | awk -F':' '/Manufacturer/{print $2}' | sed -n '1p'`
MEM_SIZE=`dmidecode -t 17 | sed -e '/./{H;$!d}' -e 'x;/Rank: 2/!d' | awk -F':' '/Size/{print $2}' | sed -n '1p'`
MEM_NUM=`dmidecode -t 17 | sed -e '/./{H;$!d}' -e 'x;/Rank: 2/!d' | awk -F':' '/Size/{print $2}' | wc -l`
touch /tmp/TMPFILE
lshw > /tmp/TMPFILE
FILE=/tmp/TMPFILE
DISK_PRODUCKT=`cat $FILE| grep -A12 'disk' | awk -F':' '/vendor/{print $2}' | sed -n '1p'`
DISK_SIZE=`cat $FILE | grep -A12 'disk' | awk -F':' '/size/{print $2}' | sed -n '1p'`
DISK_NUM=`cat $FILE | grep -A12 'disk' | awk -F':' '/size/{print $2}' | wc -l`

NETWORK_PRODUCKT=`cat $FILE | grep -A12 'network' | awk -F':' '/vendor/{print $2}'`
NETWORK_MODEL=`cat $FILE | grep -A12 'network' | awk -F':' '/product/{print $2}'`
NETWORK_SPEED=`cat $FILE | grep -A12 'network' | awk -F':' '/size/{print $2}'`
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
主板厂商：$BOARD_FIRM_NAME
主板型号：$BOARD_TYPE
主板序列号：$BOARD_SERIAL
--------------------------------------------------------------------------------
CPU型号：$CPU_MODEL
CPU核数：$CPU_KENAL_NUM
--------------------------------------------------------------------------------
内存厂商：$MEM_PRODUCKT
内存大小：$MEM_SIZE
内存块数：$MEM_NUM
--------------------------------------------------------------------------------
磁盘厂商：$DISK_PRODUCKT
磁盘大小：$DISK_SIZE
磁盘块数：$DISK_NUM
--------------------------------------------------------------------------------
网卡厂商：$NETWORK_PRODUCKT
网卡型号：$NETWORK_MODEL
网卡速率：$NETWORK_SPEED        
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"