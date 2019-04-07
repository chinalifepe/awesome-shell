#!/bin/bash

dd if=/dev/zero of=/dev/sdb bs=512 count=1 &>/dev/null

echo "n
p
1


p
w" | fdisk /dev/sdb &>/dev/null


partprobe /dev/sdb
sync
sleep 3

mkfs -t ext4 /dev/sdb1 &>/dev/null
mkdir /data &>/dev/null
mount /dev/sdb1 /data
df -h
echo "已完成"