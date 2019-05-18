##  spark2.3.4安装
安装包下载地址：http://spark.apache.org/downloads.html
### 前提准备
1. hadoop3.2.0
2. jdk1.8+
3. spark-2.4.3-bin-hadoop2.7.tgz
4. scala2.12.8
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
    vim spark-env.sh
    
    # 配置以下内容
    export JAVA_HOME=/usr/local/jdk1.8.0_211
    export HADOOP_HOME=/usr/local/hadoop-3.2.0
    export SCALA_HOME=/usr/local/scala-2.12.8
    export SPARK_HOME=/usr/local/spark-2.4.3-bin-hadoop2.7
    export HADOOP_CONF_DIR=${HAOOP_HOME}/etc/hadoop
    export SPARK_MASTER_IP=master
    export SPARK_WORKER_MEMORY=4g
    export SPARK_WORKER_CORES=1
    export SPARK_WORKER_INSTANCES=1
    export SPARK_DIST_CLASSPATH=$(hadoop classpath)
  ```
3. 配置slaves文件
  ```shell
  cp slaves.template slaves
  ```
4. 启动spark
  ```shell
  cd ../sbin
  ./start-all.sh
  # 查看spark是否启动
  jps
  ```
5. web方式访问
```
 浏览器打开http://ip:8080
```
6. spark-shell
```shell
spark-shell
 浏览器打开http://ip:4040
```
