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
  修改文件文件以下几项内容：
  * 将xml文件中所有${system:java.io.tmpdir}替换为/usr/local/apache-hive-3.1.1/tmp
  * 将xml文件中所有${system:user.name}替换为root
  * 配置metastore元数据库为mysql(此项可不配，hive默认使用Derby数据库)
    需要将相应的jdbcjar包复制到${HIVE_HOME}/lib下
    ```xml
      <property>
        <name>hive.metastore.db.type</name>
        <value>mysql</value>
        <description>
        Expects one of [derby, oracle, mysql, mssql, postgres].
        Type of database used by the metastore. Information schema &amp; JDBCStorageHandler depend on it.
        </description>
      </property>
      <property>
         <name>javax.jdo.option.ConnectionURL</name>
         <value>jdbc:mysql://127.0.0.1:3306/metastore_db?createDatabaseIfNotExist=true&amp;characterEncoding=UTF-8&amp;useSSL=false</value>
         <description>
          JDBC connect string for a JDBC metastore.
          To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
          For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
         </description>
      </property>
      <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>root</value>
        <description>password to use against metastore database</description>
      </property>
      <!--mysql8.x版本驱动，mysql5.x配置为com.mysql.jdbc.driver-->
      <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.cj.jdbc.Driver</value>
        <description>Driver class name for a JDBC metastore</description>
      </property>
    ```
 3.启动hive
    
    
