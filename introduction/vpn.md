# VPN
> 更新时间
```
timedatectl set-timezone Asia/Shanghai
```
> 将所需的翻墙端口打开
> 可以是443,或者其他

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

> 安装x-ui面板
```
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```
> bbr 加速脚本,直接选择11
```
wget -N --no-check-certificate "https://github.000060000.xyz/tcpx.sh" && chmod +x tcpx.sh && ./tcpx.sh
```

> bbr 优化,先选2，后选3即可
```
bash <(curl -Ls https://github.com/lanziii/bbr-/releases/download/123/tools.sh)
```






