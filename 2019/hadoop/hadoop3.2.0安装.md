## hadoop3.2.0安装
安装包下载：https://hadoop.apache.org/releases.html

### 安装须知
* Apache Hadoop 3.x现在仅支持Java 8
* 从2.7.x到2.x的Apache Hadoop支持Java 7和8
### 安装环境
  centos7

### 前置步骤
1. 虚拟机安装3台centos7服务器，修改它们的hostname,为node1,node2,node3
```shell
    hostnamectl set-hostname node1
    hostnamectl set-hostname node2
    hostnamectl set-hostname node3 
```
2. 指定node1服务器为namenode,其他机器为datanode

3. 查看三台服务器ip地址，修改配置文件/etc/hosts/<br>
```text
    192.168.199.101 node1
    192.168.199.102 node2
    192.168.199.103 node3
```

### 安装步骤
1. 下载安装包，解压，配置环境变量
```shell
  tar zxvf  hadoop-3.2.0.tar.gz
  export HADOOP_HOME=/usr/local/hadoop3.2.0
```
2. hadoop支持三种安装，本次安装采用全分布式模式
  * [本地模式](https://hadoop.apache.org/docs/r3.2.0/hadoop-project-dist/hadoop-common/SingleCluster.html)
  * [伪分布式模式](https://hadoop.apache.org/docs/r3.2.0/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation)
  * [完全分布式模式](https://hadoop.apache.org/docs/r3.2.0/hadoop-project-dist/hadoop-common/SingleCluster.html#Fully-Distributed_Operation)      
3. 修改配置文件<br>
进入hadoop配置目录下
```shell
  cd /usr/local/hadoop3.2.0/etc/hadoop
```

* core-site.xml
	```xml
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://node1:9000</value>
	</property>
	<property>
		<name>hadoop.tmp.dir</name>
		<value>/home/hadoop/tmp/</value>
	</property>
	```
* hdfs-site.xml
	* namenode
	```xml
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>/usr/local/hadoop-3.2.0/data/namenode</value>
	</property>
	```
	* datanode
	```xml
	<property>
		<name>dfs.datanode.name.dir</name>
		<value>/usr/local/hadoop-3.2.0/data/datanode</value>
	</property>
	```
* mapred-site.xml
	```xml
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
	</property>
	```
* yarn-site.xml
	```xml
	<property>
		<name>yarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
	</property>
	<property>
		<name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
		<value>org.apache.hadoop.mapred.ShuffleHandler</value>
	</property>
	```
4. 指定一台机器为namenode，其他机器为datanode,namenode机器第一次启动HDFS时，必须对其进行格式化。将新的分布式文件系统格式化为hdfs
```shell
#初始化hdfs
$HADOOP_HOME/bin/hdfs namenode -format
#hadoop 3.x
hdfs --daemon start namenode
hdfs --daemon start datanode
```
5.  命令行方式查看hadoop集群状态
```shell
hdfs dfsadmin -report
```

6.  web界面方式查看hadoop集群状态
```shell
#查看hadoop端口
netstat -ntlp|grep java
浏览器打开http://node1:9870
```
### 配置各服务器免密登录
 由于分布式环境，hadoop服务一台一台启动比较麻烦，可通过修改$HADOOP_HOME/etc/hadoop/workers配置其他hadoop节点hostname,配置文件内容如下
 ```
 nodel
 node2
 node3
 ```
 1. 在node1上生成ssh公钥
 ```shell
 ssh-keygen -t rsa
 ```
 2. 将公钥复制到所有机器上
 ```shell
 ssh-copy-id node1
 ssh-copy-id node2
 ssh-copy-id node3
 ```
