# EXPLAIN
###### 语法

```
{EXPLAIN | DESCRIBE | DESC}
    tbl_name [col_name | wild]

{EXPLAIN | DESCRIBE | DESC}
    [explain_type]
    {explainable_stmt | FOR CONNECTION connection_id}

explain_type: {
    EXTENDED
  | PARTITIONS
  | FORMAT = format_name
}

format_name: {
    TRADITIONAL
  | JSON
}

explainable_stmt: {
    SELECT statement
  | DELETE statement
  | INSERT statement
  | REPLACE statement
  | UPDATE statement
}
```
###### 举例
```
-- 展示表信息
EXPLAIN `user`;

-- 展示表中列信息
EXPLAIN `user` username;

-- 展示user表中已u打头列信息
EXPLAIN `user` 'u%';

-- 使用json格式分析sql信息
EXPLAIN FORMAT=JSON select * from `user` where username = 'test';

```
###### EXPLAIN输出列含义

![EXPLAIN输出列](https://github.com/jsjchai/blog/blob/master/2019/mysql/EXPLAIN/EXPLAIN%E8%BE%93%E5%87%BA%E5%88%97.png)
* id (JSON name: select_id)

>选择标识符。在使用UNION语句时为NULL

* select_type (JSON name: none)

|select_type值|json名称| 含义 |
 | :-----:|  :-----: | :-----: |
 |SIMPLE|- |简单选择(不使用union或子查询)|
 |PRIMARY|- |最外层的查询 举例：```SELECT * from user UNION select * from dept;```|
 |UNION|- |除第一个查询以外UNION查询|
 |DEPENDENT UNION|	dependent (true) |除第一个查询以外UNION查询，并依赖于外部查询|
 |UNION RESULT|union_result |UNION查询结果|
 |SUBQUERY|-|第一个子查询|
 |DEPENDENT SUBQUERY|	dependent (true)|第一个子查询，并依赖于外部查询|
 |DERIVED|-|派生表|
 |MATERIALIZED|materialized_from_subquery|被物化的子查询|
 |UNCACHEABLE SUBQUERY|cacheable (false)|无法缓存结果且必须为外部查询的每一行重新计算结果的子查询|
 |UNCACHEABLE UNION|cacheable (false)|除第一个查询以外无缓存UNION子查询|

* table (JSON name: table_name)
>输出行引用的表的名称

 1. &lt;unionM,N&gt;: id为M和N的union查询的并集
 2. &lt;derivedN&gt;: id为N派生表查询结果
 3. &lt;subqueryN&gt;：id为N子查询结果
* partitions (JSON name: partitions)
* type (JSON name: access_type)

###### 参考文档

>select_type有那些值：https://blog.csdn.net/bigtree_3721/article/details/51338104<br>
了解查询执行计划:https://dev.mysql.com/doc/refman/5.7/en/execution-plan-information.html
