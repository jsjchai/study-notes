### hive3.1.1安装
安装包下载：https://hive.apache.org/downloads.html
#### 安装环境
centos7
#### 前提准备
* jdk8
* hadoop3.x
#### 安装步骤
1. 下载安装包，解压到/usr/local/目录下,并设置HIVE_HOME
  ```shell
    tar zxvf apache-hive-3.1.1-bin.tar.gz
    export HIVE_HOME=/usr/local/apache-hive-3.1.1
  ```
2. 修改配置文件
  * 配置hive-env.sh
  ```shell
    cd /usr/local/apache-hive-3.1.1/conf
    cp hive-env.sh.template hive-env.sh
    vim hive-env.sh
    # 修改HADOOP_HOME、HIVE_CONF_DIR、HIVE_AUX_JARS_PATH
    HADOOP_HOME=/usr/local/hadoop-3.2.0
    export HIVE_CONF_DIR=/usr/local/apache-hive-3.1.1/conf
    export HIVE_AUX_JARS_PATH=/usr/local/apache-hive-3.1.1/lib
  ```
  * 配置hive-site.xml
  ```shell
    cp hive-default.xml.template hive-site.xml
  ```
