	1. kubectl api-resources 可以看当前支持的资源
	2. 生成yaml：kubectl create deployment redisserver --image=redis -o yaml --dry-run > xxxxxxxxxxxxxxx.yaml
	3. 或者从现有pod复制一个，kubectl get deployments XXXXXX -o=yaml > XXXXX.yaml
	4. 通过kubectl edit svc xxxx 可以修改service的运行yaml文件，可以实时修改
	5. Kubectl get deploy --namespace=XXXX获取某个非默认命名空间下的部署；
	6. Kubectl edit deploy --namespace=XXXX YYYYY编辑镜像
	7. 也可以通过kubectl patch XXX修改镜像
	8. 证书有效期：
      	1. cd /etc/kubernetes/pki
      	2. openssl x509 -in apiserver.crt -text -noout | grep Not
	9. Kubectl explain svc可以给出service的字段解释
	10. Kubectl explain svc.spec可以给出service中spec的字段解释
	11. Kubectl get ns 获取所有命名空间；
	12. kubectl get po XXXX yaml 查看XXX的yaml文件
	13. 通过 Kubectl explain XXX,xxx填写资源，来确定某种资源的apiVersion应该写什么，不是随便写的。
	14. 可以查看pods监听了哪些端口，就是kubectl exe XXXX -- ntestat -tnl 就是在pods内执行命令行，注意，命令行是两个-线，且两个杠前后有空格
	15. kubeadm安装的集群，1.6 版本以上的都默认开启了RBAC，查看是否开启了RBAC授权：cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep authorization-mode
	16. helm search hub wordpress，在官方仓库查找wordpress的chart
	17. 查看命名空间下所有资源：kubectl get all -n xxxxxx
	18. 删除命名空间下所有资源：kubectl delete all --all -n XXXX
	19. 查看客户端kubectl和服务端版本kubectl version
	20. 检查pod输出，kubectl logs
	21. 设置Host文件：echo "10.0.0.241 master-node" >> /etc/hosts
	22. 重新获取加入命令 kubeadm token create --print-join-command 。
	23. 查看网卡，ip a
	24. Kubectl top nodes 可以查看节点资源占用情况；
	25. Kubectl top pod -A可以查看po占用多少资源
	26. 向文件追加：cat << KK >>test.sh
	27. 向文件覆盖：cat << DD >test.sh
	28. houst文件立即生效。sudo /etc/init.d/networking restart
	29. Vim
    	1.  /etc/vim/vimrc,在行尾加上set number，永久显示行号
    	2.  删除光标至本行开头：d0
    	3.  删除光标至本行结尾：D
	30. 更改root密码：sudo passwd
	31. docker load -i xxxxx.tgz加载chart对应的离线镜像
	32. find / -name docker.service -type f 查找文件位置
	33. docker ps -a | grep xxxxx查看已创建的容器，无论是否运行。
	34. docker image inspect (docker image名称):latest|grep -i version 查看latest镜像版本
	35. systemctl status docker
	36. journalctl -xe
	37. journalctl -xefu kubelet
	38. 强制删除pod的办法：kubectl delete pods <pod> --grace-period=0 --force
	39. 替换某个目录下所有文件中某个单词
	40. sed -i "s/要查找的文本/替换后的文本/g" `grep -rl "要查找的文本" ./`
	41. 统计当前目录下文件的个数（不包括目录）: ls -l  | grep "^-" | wc -l
	42. 统计当前目录下文件的个数（包括子目录）: ls -lR | grep "^-" | wc -l
	43. 查看某目录下文件夹(目录)的个数（包括子目录）: ls -lR | grep "^d" | wc -l
	44. Wc 计算行数，单词数，字符数
	45. lsb_release -a 查看linux 的版本及发布代码（动物名字），使用的源，要用本系统发布版本号对应的源头；
	46. Traceroute 查看数据包到目的IP走过的路径，-n 直接显示IP，不解析为域名，可以减少域名解析时间；
	47. github下载文件，用raw模式打开文件，然后wget 链接就行；
	48. 所有镜像都打包
    	1.  docker save $(docker images |grep-v REPOSITORY |awk'BEGIN{OFS=":";ORS=" "}{print $1,$2}') -o iammages.tar
    	2.  docker load -i haha.tar
	49. 保存镜像
    ```
    #!/bin/sh
    sum=` docker image list |wc -l`
    COUNT=`expr $sum - 1`
    echo 镜像数量：$COUNT
    TAG=`docker image list|grep -v REPOSITORY|awk '{print $1":" $2}'|awk 'ORS=NR%"'$COUNT'"?" ":"\n"{print}'`
    echo TAG值：$TAG
    docker save $TAG -o images.tar
    ```