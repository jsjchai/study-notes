## jdk11源码编译

### 前提
  * 下载[jdk源码](http://jdk.java.net/java-se-ri/11)
### 编译环境
  * centos7
  * openjdk-11
### 安装依赖环境
```shell
 yum install -y autoconf gcc gcc-c++ libXtst-devel libXt-devel libXrender-devel libXi-devel  cups-devel fontconfig-devel alsa-lib-devel
```
### 安装步骤
1. 下载openjdk10作为Bootstrap JDK
   * 下载地址：http://jdk.java.net/java-se-ri/10
   * 解压到/opt目录
2. 配置编译参数
  ```shell
  mkdir /usr/local/jdk11
  ./configure --with-boot-jdk=/opt/jdk-10  --prefix=/usr/local/jdk11
  ```
 3. 编译make JOBS=N
  ```shell
  make JOBS=4
  make install
  ```
