# fudan_vpn_for_mac
解决关机或者休眠之后mac无法连接复旦vpn问题
**问题原因**：EasyConnect 在断开时没有自动清理 utun 接口（macOS 不允许手动 destroy）/ EasyConnect 退出后后台驱动仍然绑定系统虚拟网卡 / VPN 修改的 DNS 或默认路由没有恢复，导致下次连接失败

# 方案一：克隆本仓库并运行脚本
```
git clone https://github.com/aleeyang/fudan_vpn_for_mac.git
cd fudan_vpn_for_mac
chmod +x reset_easyconnect.sh
./reset_easyconnect.sh
open /Applications/EasyConnect.app

```
# 方案二：自己复制并运行下面代码

```
#!/bin/bash

echo "Killing EasyConnect processes..."
sudo pkill -f EasyConnect
sudo pkill -f EasyMonitor
sudo pkill -f ECAgent
sudo pkill -f ECAgentProxy

echo "Flushing DNS..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo "Resetting network interfaces..."
sudo ifconfig en0 down
sleep 1
sudo ifconfig en0 up

echo "EasyConnect environment cleaned. You can now reopen it."

chmod +x reset_easyconnect.sh
./reset_easyconnect.sh

open /Applications/EasyConnect.app


```
