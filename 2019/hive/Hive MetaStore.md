## Hive MetaStore
> Hive表和分区的所有元数据都可以通过Hive Metastore访问。启动远程metastore后,hive客户端连接metastore服务，从而可以从数据库（如：mysql）查询到元数据信息。metastore服务端和客户端通信是通过thrift协议。

## hive相关的元数据表
hive的元数据信息通常存储在关系型数据库中,默认保存在内嵌的Derby数据库中。如若要使用mysql保存元数据信息，需要修改hive-site.xml来配置。<br>

* DBS （存储Hive中所有数据库的基本信息）

| 字段 | 含义 |
| ------ | ------ |
| DB_ID | 数据库id |
| DESC | 数据库描述 | 
| DB_LOCATION_URI| 数据库HDFS路径 | 
| NAME| 数据库名 | 
| OWNER_TYPE| 所有者角色 | 

* TBLS（存储Hive表、视图、索引表的基本信息）

| 字段 | 含义 |
| ------ | ------ |
| TBL_ID| 表ID |
| CREATE_TIME| 创建时间 |
| DB_ID | 数据库id |
| LAST_ACCESS_TIME| 上次访问时间 |
| OWNER| 所有者 |
| RETENTION| 保留字段 |
| SD_ID| 序列化配置信息 |
| TBL_NAME| 表名 |
| TBL_TYPE| 表类型 |
| VIEW_EXPANDED_TEXT| 视图的详细HQL语句 |
| VIEW_ORIGINAL_TEXT| 视图的原始HQL语句 |

* DATABASE_PARAMS（存储数据库的相关参数，在CREATE DATABASE时候用）

| 字段 | 含义 |
| ------ | ------ |
| DB_ID | 数据库id |
| PARAM_KEY| 参数名 |
| PARAM_VALUE| 参数值 | 

* TABLE_PARAMS（存储数据库的相关参数，在CREATE DATABASE时候用）

| 字段 | 含义 |
| ------ | ------ |
| TBL_ID| 表ID |
| PARAM_KEY| 参数名 |
| PARAM_VALUE| 参数值 | 

## 扩展属性相关表
hive中支持一些扩展属性，数据库、表、分区、索引等都有相应的扩展属性表（表名已"_PARAMS"结尾），表结构都包含PARAM_KEY、PARAM_VALUE两个字段,通过SQL插入相应的表中
* DATABASE_PARAMS
* INDEX_PARAMS
* PARTITION_PARAMS
* SD_PARAMS
* SERDE_PARAMS
* TABLE_PARAMS

hive默认的扩展属性

| PARAM_KEY | PARAM_VALUE |
| ------ | ------ |
| numFiles | 文件个数 |
| totalSize | 数据总数 | 
| numRows | 行数 | 
| transient_lastDdlTime | 最后更新时间 | 
