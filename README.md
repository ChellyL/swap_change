# 一键修改VPS的swap大小
用于修改KVM构架的小鸡的swap大小

修改自Rat大佬的「Linux VPS一键添加/删除Swap虚拟内存」脚本，见其博客：https://www.moerats.com/archives/722/

使用该脚本：`wget https://www.moerats.com/usr/shell/swap.sh && bash swap.sh`

由于该脚本在我的bwg及virmach小鸡上失效，所以对原文进行了修改，采用了创建文件作为swap的方法，成功率更高

使用：
```
wget https://raw.githubusercontent.com/ChellyL/swap_change/main/swap.sh && bash swap.sh
```
需再次使用删除warp或修改swap大小则输入 `bash swap.sh`即可

注意仅支持KVM构架，不支持OpenVZ
