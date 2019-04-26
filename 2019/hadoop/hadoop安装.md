## hadoop3.2.0安装
安装包下载：https://hadoop.apache.org/releases.html

### 前提
Apache Hadoop 3.x现在仅支持Java 8
从2.7.x到2.x的Apache Hadoop支持Java 7和8
### 安装环境
  centos7

### 前置步骤
1. 虚拟机安装3台centos7服务器，修改它们的hostname,为node1,node2,node3
2. 指定node1服务器为namenode,其他机器为datanode
    hostnamectl set-hostname node1
    hostnamectl set-hostname node2
    hostnamectl set-hostname node3 
3. 查看三台服务器ip地址，修改配置文件/etc/hosts/<br>
    192.168.199.101 node1<br>
    192.168.199.102 node2<br>
    192.168.199.103 node3<br>

### 安装步骤
1. 下载安装包，解压，配置环境变量
```shell
  tar zxvf  hadoop-3.2.0.tar.gz
```
2. hadoop支持三种安装，本次安装采用全分布式模式
  * 本地（独立）模式
  * 伪分布式模式
  * 全分布式模式      
3. 修改etc/hadoop/core-site.xml文件
```xml
<property>
	<name>fs.defaultFS</name>
	<value>hdfs://node1:9000</value>
</property>
```
4. 配置hdsf数据保存文件路径和日志保存路径

namenode
```xml
<property>
	<name>dfs.namenode.name.dir</name>
	<value>/usr/local/hadoop-3.2.0/data/namenode</value>
</property>
```
datanode
```xml
<property>
	<name>dfs.datanode.name.dir</name>
	<value>/usr/local/hadoop-3.2.0/data/datanode</value>
</property>
```
5. 指定一台机器为namenode，其他机器为datanode,namenode机器第一次启动HDFS时，必须对其进行格式化。将新的分布式文件系统格式化为hdfs
```shell
#初始化hdfs
$HADOOP_HOME/bin/hdfs namenode -format
#hadoop 2.x
$HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
#hadoop 3.x
hdfs --daemon start namenode
hdfs --daemon start datanode
```
6.  命令行方式查看hadoop集群状态
```shell
hdfs dfsadmin -report
```

7.  web界面方式查看hadoop集群状态
```shell
#查看hadoop端口
netstat -ntlp|grep java
浏览器打开http://node1:9870
```
