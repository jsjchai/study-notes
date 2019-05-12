## Hive常用SQL举例
### 数据库
* 新建数据库,并添加扩展参数
```sql
CREATE DATABASE IF NOT EXISTS d_test COMMENT 'demo' WITH DBPROPERTIES ("createor"="tinahe");
```
* 删除数据库,默认的情况下，hive不允许删除一个含有表的数据库,CASCADE参数可以在不论数据库存不存表强制删除数据库
```sql
DROP DATABASE IF EXISTS tianhe_test CASCADE;
```
* 修改数据库扩展参数(扩展参数无法删除，只能修改)
```sql
ALTER DATABASE d_test SET DBPROPERTIES ("createor"="tinahe1");
```
* 查询数据库扩展参数
```sql
DESC DATABASE EXTENDED d_test;
```
* 使用数据库
```sql
use d_test;
```
* 查询所有数据库
```sql
show DATABASES;
```
* 模糊搜索数据库
```sql
show DATABASES like 'a*';
```
### 表
* 查询所有表
```sql
show tables;
```
* 模糊搜索表
```sql
show tables '*_*';
```
* 创建表，并配置列格式
```sql
CREATE TABLE serde_regex(
  host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  size STRING,
  referer STRING,
  agent STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^ ]*) ([^ ]*) ([^ ]*) (-|\\[[^\\]]*\\]) ([^ \"]*|\"[^\"]*\") (-|[0-9]*) (-|[0-9]*)(?: ([^ \"]*|\"[^\"]*\") ([^ \"]*|\"[^\"]*\"))?",
  "output.format.string" = "%1$s %2$s %3$s %4$s %5$s %6$s %7$s %8$s %9$s"
)
STORED AS TEXTFILE;
```
* 查询所有列信息
```sql
--表明细信息，包括表创建时间等
desc formatted serde_regex;
--表信息概况
desc  serde_regex;
```
* 创建表，设置扩展参数
```sql
-- 配置表生命周期
CREATE TABLE IF NOT EXISTS employee (
	eid INT COMMENT '员工编号',
	name varchar(50) COMMENT '姓名',
	age SMALLINT COMMENT '年龄' ,
	status TINYINT COMMENT '1-有效，2-删除',
	email String  COMMENT '邮箱',
	gmt_create String COMMENT '入职时间'
) COMMENT 'Employee details' 
TBLPROPERTIES ("period"="20") ;
```
* 查询表扩展属性
```sql
-- 查询所有扩展属性
SHOW TBLPROPERTIES employee;
-- 查询单个扩展属性
SHOW TBLPROPERTIES employee("period");
```
* 展示创建表sql语句
```sql
SHOW CREATE TABLE employee;
```
* 删除表
```sql
DROP TABLE IF EXISTS employee;
```
* 修改表属性
```sql
ALTER TABLE employee SET TBLPROPERTIES("period"="30") ;
```

* 修改表备注
```sql
ALTER TABLE employee SET TBLPROPERTIES ('comment' = 'Employee table details');
```
### 列
* 添加列
```sql
ALTER TABLE employee ADD COLUMNS (gender TINYINT COMMENT '性别');
```
* 更新列
```sql
ALTER TABLE employee REPLACE COLUMNS (	
        eid INT COMMENT '员工编号',
	name varchar(50) COMMENT '姓名',
	age SMALLINT COMMENT '年龄' ,
	status TINYINT COMMENT '1-有效，2-删除',
	email String  COMMENT '邮箱',
	gmt_create String COMMENT '入职时间'
);
```

* 将employee表name列排到第一列
```sql
ALTER TABLE employee CHANGE name  name varchar(50) FIRST;
```
* 将employee表age列排到name列之后
```sql
ALTER TABLE employee CHANGE age age SMALLINT AFTER name;
```

### 分区
* 添加分区
```shell
ALTER TABLE employee ADD PARTITION (dt='2019-04-29')
```
* 动态分区，分区可以配合insert语句创建
```sql
CREATE TABLE pageviews (userid VARCHAR(64), link STRING, came_from STRING)
  PARTITIONED BY (datestamp STRING) CLUSTERED BY (userid) INTO 256 BUCKETS STORED AS ORC;
 
INSERT INTO TABLE pageviews PARTITION (datestamp = '2014-09-23')
  VALUES ('jsmith', 'mail.com', 'sports.com'), ('jdoe', 'mail.com', null);

 -- 开启动态分区
 set hive.exec.dynamic.partition.mode=nonstrict;

 INSERT INTO TABLE pageviews PARTITION (datestamp)
  VALUES ('tjohnson', 'sports.com', 'finance.com', '2014-09-23'), ('tlee', 'finance.com', null, '2014-09-21');
  
INSERT INTO TABLE pageviews
  VALUES ('tjohnson', 'sports.com', 'finance.com', '2014-09-23'), ('tlee', 'finance.com', null, '2014-09-21');
 
```
* 查看分区
```sql
show  partitions pageviews;
```
* 删除分区
```sql
alter table pageviews drop partition(datestamp='2014-09-21');
```
