# 04.kylin-k8s-install

### 关闭交换分区

```
swapoff -a 
cp -p /etc/fstab /etc/fstab.bak$(date '+%Y%m%d%H%M%S')
sed -i "s/\/dev\/mapper\/centos-swap/\##\/dev\/mapper\/centos-swap/g" /etc/fstab
systemctl daemon-reload
```

### 设置时间同步

```
timedatectl set-timezone Asia/Shanghai
```

### 设置机器名

```
hostnamectl set-hostname master
hostname newname
```

### 关闭过滤

```
sudo modprobe br_netfilter
lsmod | grep br_netfilter
```

### 关闭selinux

```
cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
```

### 安装docker

```
通过离线方式安装
```

### 配置 Docker daemon，设置cgroupdriver为systemd

```
vim /etc/docker/daemon.json

{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "insecure-registries": ["10.0.0.231:8082","10.0.0.231:8083"],
  "registry-mirrors": ["http://10.0.0.231:8083"]
}
```

### 重启 docker 后台服务

```
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl restart docker
sudo systemctl status docker
```

### 导入images

```
docker load -i xxxxxxx.tar
```

### kubeadm、kubelet、kubectl的安装

> 方法一：可以使用离线导入的方式

```
dpkg -i xxxx.deb
```

> 方法二：添加阿里云镜像源

```
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-cache show kubeadm | grep Version
```

> 方法三：添加官方仓库源

```
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
apt-cache show kubeadm | grep Version
```

> 然后可使用所需的版本号直接安装

```
export K8S_VERSION=1.23.5-00
apt-get install kubelet=${K8S_VERSION} 
apt-get install kubeadm=${K8S_VERSION} 
apt-get install kubectl=${K8S_VERSION}
sudo apt-mark hold kubelet kubeadm kubectl
```

### 重启 kubelet 后台服务

```
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl restart kubelet
sudo systemctl status kubelet
```

### 初始化集群,在主节点执行

```
kubeadm init \
--apiserver-advertise-address=10.0.0.107 \
--image-repository registry.aliyuncs.com/google_containers \
--control-plane-endpoint=10.0.0.107 \
--kubernetes-version v1.23.5 \
--service-cidr=10.96.0.0/16 \
--pod-network-cidr=10.244.0.0/16\
```

### 安装网络插件

```
##flannel的网络设置要与init里的pod网络设置一致，否则后面能ready但是不能通信。
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

### 查看flennel网络配置

```
cat /run/flannel/subnet.env
```

### coreDns出错

> 日志

```
Forwarding loop detected in "." zone. Exiting. See https://coredns.io/plugins/loop##troubleshooting
```

> 则执行

```
1.kubectl edit cm coredns -n kube-system
2.delete ‘loop’ , save and exit
3.kubctel delete pod xxxxx -n kube-system
```

### 加入节点

> 复制加入节点

### 要使非 root 用户可以运行 kubectl，请运行以下命令，分两种情况

> 假如你目前不是root，则执行以下命令

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

> 假如你目前是root，则

```
	export KUBECONFIG=/etc/kubernetes/admin.conf
```

> 或者

```
	echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile
	source ~/.bash_profile
```

### kubectl completion bash用于生成自动补全脚本

```
source <(kubectl completion bash)                                       
echo "source <(kubectl completion bash)" >> ~/.bashrc  
```
