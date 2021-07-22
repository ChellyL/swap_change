#!/usr/bin/env bash
#改自Rat大佬的脚本见Blog:https://www.moerats.com/

Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

#root权限
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}Error:脚本运行需root权限！${Font}"
        exit 1
    fi
}

#检测ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}脚本只支持KVM，不支持OpenVZ构架${Font}"
        exit 1
    fi
}

add_swap(){
echo -e "${Green}请输入需要添加的swap，建议为内存的2倍！${Font}"
read -p "请输入swap数值:" swapsize


#删除原本的swap
swapoff -a
#创建swap文件
dd if=/dev/zero of=/swapfile bs=1M count=${swapsize}
#格式化分区
mkswap /root/swapfile
#启用swap
swapon /root/swapfile
#设置开机启动
echo '/root/swapfile none swap defaults 0 0' >> /etc/fstab

echo -e "${Green}swap创建成功，并查看信息：${Font}"
free -m
}

del_swap(){
echo -e "${Green}将删除系统原本的swap或本脚本创建的swapfile${Font}"
swapoff -a
rm -f /root/swapfile
echo -e "${Green}swap已删除！${Font}"
}

#开始菜单
main(){
root_need
ovz_no
clear
echo -e "———————————————————————————————————————"
echo -e "${Green}Linux VPS一键添加/删除swap脚本${Font}"
echo -e "${Green}1、添加swap${Font}"
echo -e "${Green}2、删除swap${Font}"
echo -e "———————————————————————————————————————"
read -p "请输入数字 [1-2]:" num
case "$num" in
    1)
    add_swap
    ;;
    2)
    del_swap
    ;;
    *)
    clear
    echo -e "${Green}请输入正确数字 [1-2]${Font}"
    sleep 2s
    main
    ;;
    esac
}
main
