#!/bin/bash

fdisk -l | grep -o "^Disk /dev/[sh]d[a-z]"

read -p "Your choice: " choice
read -p "Your mount: " dirmount
until [ $choice != 'q' -a $choice != 'Q' -a $choice != 'quit' -a $choice != 'Quit' ]&& fdisk -l | grep -o "^Disk /dev/[sh]d[a-z]"|grep $choice;do
if [ $choice == 'q' -o $choice == 'Q' -o $choice == 'quit' -o $choice == 'Quit' ];then  echo "The shell is quiting"
exit 5
else
echo "Wrong options"
read -p "Your choice: " choice
fi
done
echo "Disk $choice is to init,this will destroy all data.Are you sure"
read -p "Continue? Y|y or N|n: " choiceyn
if [ $choiceyn == 'N' -o $choiceyn == 'n' ];then
echo "You chose no"
echo "The shell is quiting"
exit 5
elif [ $choiceyn == 'Y' -o $choiceyn == 'y' ];then
echo "You chose yes,init will begin"
echo "initing....please wait"
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
read -p "Your newdisk: " newdisk

mkfs -t ext4 $newdisk &>/dev/null
mkdir /$dirmount &>/dev/null
mount $newdisk /$dirmount
echo "Init finish"  
