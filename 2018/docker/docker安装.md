# docker安装<br>

> 系统版本 centos7<br>

1. 版本<br>
Community Edition (CE) 社区版<br>
Enterprise Edition (EE) 企业版<br>
2. 官网文档<br>  https://docs.docker.com/v17.09/engine/installation/<br>
3. 安装步骤<br>
 * 移除旧的版本<br>
```
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
```
 * 安装一些必要的系统工具：<br>
```yum install -y yum-utils device-mapper-persistent-data lvm2``` <br>
 * 添加软件源信息：<br>
```yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo```<br>
或者<br>
```yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo```#速度比较慢<br>
 * 更新 yum 缓存：<br>
```yum makecache fast```<br>
 * 安装 Docker-ce：<br>
```yum -y install docker-ce```<br>
 * 启动 Docker 后台服务：<br>
```systemctl start docker```
 * 测试运行 hello-world<br>
```docker run hello-world```
