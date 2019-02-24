* 查看docker版本
>docker version<br>
* 查看docker详细信息
>docker info<br>
* docker 删除镜像<br>
> https://blog.csdn.net/qq_32447301/article/details/79387649<br>

* 删除单个container<br>
> docker  rm ${name}<br>

* 停止所有的container，这样才能够删除其中的images：<br>
> docker stop $(docker ps -a -q)<br>
* 如果想要删除所有container的话再加一个指令：<br>
> docker rm $(docker ps -a -q)<br>
* 查看当前有些什么images<br>
> docker images<br>
* 删除images，通过image的id来指定删除谁<br>
> docker rmi <image id><br>
* 想要删除untagged images，也就是那些id为的image的话可以用<br>
> docker rmi $(docker images | grep "^<none>" | awk "{print $3}")<br>
* 要删除全部image的话<br>
> docker rmi $(docker images -q)<br>
* 强制删除全部image的话<br>
> docker rmi -f $(docker images -q)<br>

* docker volume
> https://www.cnblogs.com/sammyliu/p/5932996.html<br>

* 进入docker容器<br>
> docker exec -i -t 容器名称 /bin/bash<br>

* 打包镜像<br>
> docker commit -m "commit message"  容器id  新镜像名:tag<br>

* 打包阿里云<br>
>docker login --username= registry.cn-hangzhou.aliyuncs.com<br>
docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/仓库名称/镜像名：tag<br>
docker push  registry.cn-hangzhou.aliyuncs.com/仓库名称/镜像名：tag<br>
