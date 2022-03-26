# VPN
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
> 安装x-ui面板
```
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```







