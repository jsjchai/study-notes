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
```
在hive[官方文档](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)中明确说明MapReduce在hive2.0已被弃用,具体原因见[deprecate MR in Hive 2.0](https://issues.apache.org/jira/browse/HIVE-12300)

### 配置spark为默认执行引擎
1. 修改hive配置文件
  ```xml

  ```

