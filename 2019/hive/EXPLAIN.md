## EXPLAIN

Hive查询被转换成一个阶段序列(它更像是一个有向无环图)。这些阶段可能是map/reduce阶段，也可能是操作metastore阶段或文件系统操作(如移动和重命名)的阶段。explain输出有三个部分:
  * 查询的抽象语法树
  * 计划的不同阶段之间的依赖关系
  * 每个阶段的描述
```
  EXPLAIN DESC  employee;
  
  # Explain信息
  STAGE DEPENDENCIES:
  Stage-0 is a root stage
  Stage-1 depends on stages: Stage-0

  STAGE PLANS:
  Stage: Stage-0
      Describe Table Operator:
        Describe Table
          table: employee

  Stage: Stage-1
    Fetch Operator
      limit: -1
      Processor Tree:
        ListSink
```


### EXPLAIN语法
```sql
EXPLAIN [EXTENDED|CBO|AST|DEPENDENCY|AUTHORIZATION|LOCKS|VECTORIZATION|ANALYZE] query
```
