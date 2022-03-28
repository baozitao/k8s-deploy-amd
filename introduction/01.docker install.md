# install docker 
## **Offline install**
> 进入docker目录，将目录下的所有文件拷贝至“/usr/bin/”
```
cd docker/
cp * /usr/bin/
```

> 将docker 作为系统后台服务运
- 新建文件
```
vim /etc/systemd/system/docker.service
```
- 然后在文件中添加以下内容
```
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
```

- 给文件增加可执行权限
```
chmod +x /etc/systemd/system/docker.service
systemctl daemon-reload 
```

- 设置开机启动开机启动
```
systemctl enable docker.service
systemctl start docker
```

- 查看docker是否启动
```
systemctl status docker
```


> 测试docker
```
docker -v
```
## **Online Install**
### **1.prepare**
> Update the apt package index and install packages to allow apt to use a repository over HTTPS
```
apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
```

> Add Docker’s official GPG key
```
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```


> set up the stable repository
```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
### **2.Install latest Docker Engine**
> Update the apt package index
```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### **2.To install a specific version of Docker Engine**
> List the versions available in your repo
```
apt-cache madison docker-ce
```
> Install a specific version using the version string from the second column, for example, 5:18.09.1~3-0~debian-stretch
```
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

## **Verify that Docker Engine is installed correctly by running the hello-world image**
```
sudo docker run hello-world
```

## **New offline Install**
### **Install from a package**
> **1.** Go to https://download.docker.com/linux/debian/dists/, choose your Debian version, then browse to **pool/stable/**, choose amd64, armhf, or arm64, and download the .deb file for the Docker Engine version you want to install

> **2.** Install Docker Engine, changing the path below to the path where you downloaded the Docker package.
```
sudo dpkg -i /path/to/package.deb
```