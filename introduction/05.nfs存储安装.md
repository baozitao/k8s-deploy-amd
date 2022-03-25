# NFS 外挂存储
## 在NFS服务器上，安装FS服务端
```
echo yes | apt install nfs-kernel-server
```

## 客户机上安装客户端
```
echo y | apt install nfs-common
```


## 检查服务启动情况
```
systemctl status nfs-server
```


## 服务器上创建共享目录，并修改权限
```
mkdir -p /ifs/kubernetes
chmod -R 777 /ifs/kubernetes
```

## 共享权限编辑
```
echo "/ifs/kubernetes *(insecure,rw,no_subtree_check,no_root_squash)" >> /etc/exports
```

## 重启NFS
```
service nfs-kernel-server restart
```

## 查看本机/XXXX机器共享了哪些NFS
```
showmount -e
showmount -e 172.31.36.109
```


## 客户机建立共享目录
```
在kuboard中建立nfs-storageclass
```
