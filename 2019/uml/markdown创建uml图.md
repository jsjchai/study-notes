# markdown创建uml图
https://plantuml-editor.kkeisuke.com/
## 类图

```plantuml
entity Database{
    -name : String
    -comment : String
}
entity Table{
    - databaseName : String
    - name : String
    - type : String
    - createTime : Date
    - updateTime : Date
    - columnList : List<Column>
    - partitionList : List<String>
    -comment : String
}
entity Column{
    - name : String
    - type : String
    - comment : String
}
entity TableProperty{
    - propertyName : String
    - propertyValue : String
}

interface MetadataService {
    + getDatabaseNames() : List<String>
    + getTableNames(databaseName : String) : List<String>
    + getDbDetails(databaseName : String) : Database
    + getTabelDetails(databaseName : String, tableName : String) : Table
    + saveOrUpdtaeTableProperties(databaseName : String, tableName : String, tableProperties : List<TableProperty>) : void
}
interface MetadataSearchService {
    + createIndex() : void
    + search(queryParam : String, limit : int) : List<Document>
}

Database -|{  Table
Table -|{ Column

```
