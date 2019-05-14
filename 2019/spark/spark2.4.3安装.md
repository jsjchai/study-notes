##  spark2.3.4安装
安装包下载地址：http://spark.apache.org/downloads.html
### 前提准备
1. hadoop3.2.0
2. jdk1.8+
3. spark-2.4.3-bin-hadoop2.7.tgz
### 安装步骤
1. 解压，并移动到/usr/local/目录下，并配置环境变量
  ```shell
    tar zxf spark-2.4.3-bin-hadoop2.7.tgz
    export SPARK_HOME=/usr/local/spark-2.4.3-bin-hadoop2.7
  ```
2. 配置spark-env.sh
  ```shell
    #当前在spark根目录下
    cd conf
    cp spark-env.sh.template spark-env.sh
  ```
