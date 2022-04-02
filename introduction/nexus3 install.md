
# 安装 nexus3 
## 1.设置容器外内容目录

```
mkdir nexus-data
chmod 777 nexus-data/
```

## 2.拉取镜像
- arm64
```
docker pull klo2k/nexus3
```
- amd
```
docker pull sonatype/nexus3
```
## 3.安装nexus3

- arm64
```
docker run -dit --privileged --restart unless-stopped -p 8081:8081 -p 8082:8082 -p 8083:8083 -v /nexus-data:/nexus-data --name nexus3 klo2k/nexus3 
```
- amd
```
docker run -dit --privileged --restart unless-stopped -p 8081:8081 -p 8082:8082 -p 8083:8083 -v /nexus-data:/nexus-data --name nexus3 sonatype/nexus3 
```
## 4.访问nexus-web网页

- 查看密码
```
cat /nexus-data/admin.password
```
- 访问网页
```
IP:8081
登录后输入密码，修改为自己的密码
```
## 4.创建仓库
- 创建一个hosted类型的docker仓库
```
可以参考 https://www.cnblogs.com/sanduzxcvbnm/p/13099635.html
host仓库端口为8083
group仓库端口为8082
proxy仓库无端口
Name: 定义一个名称docker-local
Online: 勾选。这个开关可以设置这个Docker repo是在线还是离线。
HTTP这里勾选上，然后设置端口为8083
Allow anonymous docker pull 
Allow redeploy

repalm处添加docker那一项
```
- 重启下nexue3
```
docker restart nexus3
```


## 5.设置docker的非https和镜像仓库
- vim /etc/docker/daemon.json
```
{
  "insecure-registries": ["10.0.0.231:8082","10.0.0.231:8083"],
  "registry-mirrors": ["http://10.0.0.231:8083"]
}
```
- 重载并重启
```
systemctl daemon-reload 
systemctl restart docker
```

## 6.登录测试
```
docker login 10.0.0.231:8083
```

## 7.注意
```
通过8083端口推送到host仓库
通过8082端口group下载，可以代理下载到本地
```