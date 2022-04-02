# VPN
> 更新时间
```
timedatectl set-timezone Asia/Shanghai
```

## 可以选择自己弄acme.sh
> 将所需的翻墙端口打开，可以是443,或者其他

> 更新及安装组件
```
apt update -y          
apt install -y curl    
apt install -y socat    
```
> 安装acme脚本
```
curl https://get.acme.sh | sh
```
> 申请域名及证书
```
~/.acme.sh/acme.sh --register-account -m baozitao@gmail.com
~/.acme.sh/acme.sh  --issue -d vpn.baozitao.com   --standalone
~/.acme.sh/acme.sh --installcert -d vpn.baozitao.com --key-file /root/private.key --fullchain-file /root/cert.crt
```
> 证书位置
```
/root/cert.crt
/root/private.key
```
> 证书是90天的，acme.sh设置了linux conjob自动更新计划，快到期就自动更新，可以查看自动更新任务
```
crontab -l
> 47 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
```

> 也可以手动更新
```
acme.sh --cron -f
```

> 目前由于 acme 协议和 letsencrypt CA 都在频繁的更新, 因此 acme.sh 也经常更新以保持同步.所以为了省心省力，最好还是设置一下软件的自动更新，执行下面的命令就可以了
```
acme.sh  --upgrade  --auto-upgrade
```
## 也可以选择使用x-ui自带的工具完成
> 安装x-ui面板
```
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```
## 可以选择使用脚本开启
> bbr 加速脚本,直接选择11
```
wget -N --no-check-certificate "https://github.000060000.xyz/tcpx.sh" && chmod +x tcpx.sh && ./tcpx.sh
```

> bbr 优化,先选2，后选3即可
```
bash <(curl -Ls https://github.com/lanziii/bbr-/releases/download/123/tools.sh)
```


## 最好使用内核自带的bbr+fq
> 增加官方backports 的 bbr 源
```
echo “deb http://deb.debian.org/debian buster-backports main” | sudo tee /etc/apt/sources.list.d/vpsadmin.list
```


> 刷新软件库并查询 Debian 官方的最新版内核并安装。请务必安装你的 VPS 对应的版本（本文以比较常见的【amd64】为例）
```
sudo apt update && sudo apt -t buster-backports install linux-image-amd64
```

> 修改 kernel 参数配置文件 sysctl.conf 并指定开启 BBR
```
cat << EOF >> /etc/sysctl.d/vpsadmin.conf
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
```

> 重启机器，是内核更新和BBR设置生效
```
sudo reboot
```

> 查看bbr 是否开启
```
lsmod | grep bbr

> tcp_bbr
```

> fq 算法是否开启
```
lsmod | grep fq

> sch_fq
```






