#!/bin/bash
images=(
    kube-apiserver:v1.23.5
    kube-controller-manager:v1.23.5
    kube-scheduler:v1.23.5
    kube-proxy:v1.23.5
    pause:3.6
    etcd:3.5.1-0
    coredns:v1.8.6
)

for imageName in ${images[@]} ; do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
done
