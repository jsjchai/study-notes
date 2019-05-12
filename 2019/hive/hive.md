### hive
#### 什么是hive
> hive是基于Hadoop的一个数据仓库工具，可以将结构化的数据文件映射为一张数据库表，通过SQL方式查询，分析和处理结构化数据
#### hive的组成部分
![image](https://github.com/jsjchai/study-notes/blob/master/2019/hive/images/hive%E7%BB%84%E4%BB%B6.jpg)
* 用户接口（User Interface） 
  由cli、Shell命令行、webUI等几部分组成，方便用户与HDFS之间进行交互
* 元数据存储（MetaStore） 
  保存hive数据库、表、分区、HDFS映射等基础数据
* hive流程引擎（HiveQL Process Engine） 
  HiveQL是用于查询Metastore的模式信息的语言，类似于SQL语言。它不是用Java语言编写MapReduce程序，而是能够向MapReduce工作编写查询
* 执行引擎（Execution Engine） 
  HiveQL执行引擎是HiveQL流程引擎和MapReduce之间的组合的一部分。执行引擎处理查询并使用MapReduce生成相同的结果
* 数据存储 
  基于HDFS或HBase存储数据
#### hive数据单元
* 数据库 
* 表
* 分区 每个表可以有一个或多个分区，细化数据管理，使查询数据更快
* Buckets (or Clusters) 每个分区中的数据又可以基于表的某些列的散列函数的值被划分为桶，有效地采样数据
#### hive支持数据类型
* Numeric : TINYINT, SMALLINT, INT, BIGINT, FLOAT, DOUBLE, DECIMAL
* String : STRING, VARCHAR, CHAR
* Date and time types : TIMESTAMP, DATE
* Boolean type : BOOLEAN(TRUE/FALSE)
* Binary types : BINARY
#### hive3.x
* 支持Hbase作为MeateStore数据源
* 不建议使用MapReduce，建议使用Tez或Spark
* 支持存储过程
* Metastore可以独立于hive其他组件运行
#### 参考文档
  * [About Hive 1 – Preview](http://bitnine.net/blog-computing/about-hive-1-preview/)
  * [Hive Tutorial](https://cwiki.apache.org/confluence/display/Hive/Tutorial#Tutorial-WhatIsHive)

