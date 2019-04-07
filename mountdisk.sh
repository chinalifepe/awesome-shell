#!/bin/bash

fdisk -l | grep -o "^磁盘 /dev/[sh]d[a-z]"

read -p "请输入需要挂载的磁盘: " choice
echo "输入q或Q退出程序"
until [ $choice != 'q' -a $choice != 'Q' -a $choice != 'quit' -a $choice != 'Quit' ]&& fdisk -l | grep -o "^Disk /dev/[sh]d[a-z]"|grep $choice;do
if [ $choice == 'q' -o $choice == 'Q' -o $choice == 'quit' -o $choice == 'Quit' ];then  echo "程序已退出"
exit 5
else
echo "输入错误"
read -p "请输入需要挂载的磁盘: " choice
fi
done
echo "磁盘 $choice 即将初始化分区，请确认"
read -p "(y or n): " choiceyn
if [ $choiceyn == 'N' -o $choiceyn == 'n' ];then

echo "程序已退出"
exit 5
elif [ $choiceyn == 'Y' -o $choiceyn == 'y' ];then

echo "正在初始化....请稍后"
dd if=/dev/zero of=$choice bs=512 count=1 &>/dev/null
echo "n
p
1


p
w" | fdisk $choice &>/dev/null
fi
partprobe $choice
sync
sleep 3

fdisk -l
read -p "请输入需要挂载的分区: " newdisk
read -p "请输入挂载路径: " dirmount

mkfs -t ext4 $newdisk &>/dev/null
mkdir /$dirmount &>/dev/null
mount $newdisk /$dirmount
echo "已成功完成"  
