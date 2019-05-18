## 将hive默认的执行引擎MapReduce换为spark

### 为什么不用MapReduce？
```xml
  <property>
    <name>hive.execution.engine</name>
    <value>mr</value>
    <description>
      Expects one of [mr, tez, spark].
      Chooses execution engine. Options are: mr (Map reduce, default), tez, spark. While MR
      remains the default engine for historical reasons, it is itself a historical engine
      and is deprecated in Hive 2 line. It may be removed without further warning.
    </description>
  </property> 
```
在hive[官方文档](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)中明确说明MapReduce在hive2.0已被弃用,具体原因见[deprecate MR in Hive 2.0](https://issues.apache.org/jira/browse/HIVE-12300)

### 安装spark
* Hive on Spark 默认支持YARN模式下的Spark
* hive[源码](https://github.com/apache/hive)pom.xml文件<spark.version>定义了spark版本
* 安装spark版本不能有任何hive的jar包
* 安装步骤：
  * 下载spark[源码](https://archive.apache.org/dist/spark/spark-2.3.0/),解压
    ```shell
    tar zxf spark-2.3.0.tgz
    ```
  * 编译
    ```shell
    cd spark-2.3.0
    ./dev/make-distribution.sh --name "hadoop2-without-hive" --tgz "-Pyarn,hadoop-provided,hadoop-2.7,parquet-provided,orc-provided"
    mv spark-2.3.0-bin-hadoop2-without-hive.tgz /usr/local/
    cd /usr/local/
    tar zxf spark-2.3.0-bin-hadoop2-without-hive.tgz
    rm spark-2.3.0-bin-hadoop2-without-hive.tgz
    ```

### 配置spark为默认执行引擎
1. 将sparkjar包复制到$HIVE_HOME/lib下
  hive2.2.0版本及Spark 2.0.0版本，复制以下jar包
  * scala-library-X.XX.XX.jar
  * spark-core_X.XX-X.X.X.jar
  * spark-network-common_X.XX-X.X.X.jar .
  ```shell
   cd /usr/local/apache-hive-3.1.1/lib
   cp /usr/local/spark-2.4.3-bin-hadoop2.7/jars/scala-library-2.11.12.jar .
   cp /usr/local/spark-2.4.3-bin-hadoop2.7/jars/spark-core_2.11-2.4.3.jar .
   cp /usr/local/spark-2.4.3-bin-hadoop2.7/jars/spark-network-common_2.11-2.4.3.jar .
  ```
  hive2.2.0以下版本复制spark-assembly.*.jar
2. 修改hive配置文件hive-site.xml
  ```xml
  <property>
    <name>hive.execution.engine</name>
    <value>spark</value>
  </property>
  ```

