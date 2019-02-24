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

![EXPLAIN输出列](https://github.com/jsjchai/study-notes/blob/master/2019/mysql/EXPLAIN/EXPLAIN%E8%BE%93%E5%87%BA%E5%88%97.png)
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
>查询将从其中匹配记录的分区。对于非分区表，该值为NULL。
* type (JSON name: access_type)
>连接类型<br>
system<br>
const连接类型的特例。该表只有一行（=系统表）<br>
const<br>
该表最多只有一个匹配行，在查询开头读取。因为只有一行，所以优化器的其余部分可以将此行中列的值视为常量。 const表非常快，因为它们只读一次。const将一个主键或唯一索引的所有部分与常量值进行比较时使用。<br>
eq_ref<br>
对于前一个表中的每个行组合，从这个表中读取一行。除了系统和const类型之外，这是最好的连接类型。当连接使用索引的所有部分，且该索引是主键或惟一非空索引时，将使用该索引。<br>
ref<br>
关联查询时，读取所有具有匹配索引值的行。ref如果查询的字段不是主键或唯一索引（不是单行查询），则返回此类型。ref可以用于使用 = or <= > 运算符进行比较的索引列。<br>
fullText<br>
使用了全文索引。<br>
ref_or_null
会对包含NULL值的行进行额外搜索ref类型。此连接类型优化最常用于解析子查询。
index_merge<br>
索引合并优化
unique_subquery<br>
eq_ref某些 IN子查询<br>
index_subquery<br>
非唯一索引IN子查询<br>
range<br>
仅检索给定范围内的行，并使用索引查询。当使用=，<>，>，>=，<，<=，is NULL， <=>， BETWEEN, LIKE, or IN()运算符将查询列与常量进行比较时，返回range类型<br>
ALL<br>
全表扫描。数据比较多的情况下，需要添加索引。

* possible_keys (JSON name: possible_keys)
>表示MySQL可以从中选择哪些索引来查找该表中的行。如果此列是NULL（或在JSON格式的输出中未定义），则没有相关索引

* key（JSON名：key）
>表示MySQL实际查询时使用的索引.如果此列是NULL，MySQL没有找到用于更有效地执行查询的索引。可以强制使用索引。

* key_len（JSON名： key_length）
>表示MySQL实际查询时使用的索引长度

* ref
>ref列显示将哪些列或常量与键列中指定的索引进行比较，以便从表中选择行。如果值为func，则使用的值是某个函数的结果。

* rows
>表示MySQL执行查询的行数。对于InnoDB，此数字是估算值，可能并不总是准确的。

* Extra （JSON名称：无）
>解析查询的其他信息.如果您想使查询尽可能快，请查找Using filesort和Using temporary列值，或者在json格式的EXPLAIN输出中查找using_filesort和using_temporary_table属性等于true的列值。

###### 查看EXPLAIN语句产生额外（扩展）信息
```
EXPLAIN  select * from user where name in ('test01','aa');
SHOW WARNINGS;
```




###### 参考文档

>select_type有那些值：https://blog.csdn.net/bigtree_3721/article/details/51338104<br>
了解查询执行计划:https://dev.mysql.com/doc/refman/5.7/en/execution-plan-information.html<br>
Extra字段解释说明：https://dev.mysql.com/doc/refman/5.7/en/explain-output.html#explain-extra-information
