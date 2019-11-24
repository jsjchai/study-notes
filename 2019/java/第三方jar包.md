# 第三方jar包
## [Apache commons](https://commons.apache.org/)
> Apache Commons封装了许多好用的工具类，使我们在开发中编写少量的代码，提高编码效率

常用的组件：

| 组件 | 功能介绍 |
| ------ | ------ |
|Lang|java基本对象方法的工具类包 如：StringUtils等|
| Codec | 处理常用的编码方法的工具类包 例如DES、SHA1、MD5、Base64等 |
| Collections | 对java集合框架扩展操作 | 
|Email|java发送邮件 对javamail的封装|
|IO|io工具的封装|

## [guava](https://github.com/google/guava)
> 谷歌开源的常用工具类，遵循高效的java语法实践，高效设计良好的API

常用核心库：

* [集合](https://github.com/google/guava/wiki/CollectionUtilitiesExplained)
* [字符串处理](https://github.com/google/guava/wiki/StringsExplained)
* [I/O](https://github.com/google/guava/wiki/IOExplained)

## [fastjson](https://github.com/alibaba/fastjson)
> 阿里开源的json工具类，可以将java对象转化成json字符串，也可以将JSON字符串转换为等效的Java对象
```java
 //java对象转化成json字符串
 User user = new User();
 user.setId("10000");
 user.setName("Tom");
 String jsonString = JSON.toJSONString(user);
 
 //JSON字符串转换为Java对象
 User u = JSON.parseObject(jsonString,User.class);
```
## [joda-time](https://www.joda.org/joda-time/)
> 由于Java SE 8之前的标准日期和时间类使用起来过于繁琐。joda-time替代了jdk的日期实现。从Java SE 8开始，请使用jdk自带的java.time
```java
DateTime dateTime = new DateTime(2019, 11, 11, 0, 0, 0, 0);
// 90天以后的时间
dateTime.plusDays(90).toString("E MM/dd/yyyy HH:mm:ss.SSS")
```

## 参考文档
* [Joda-Time 简介](https://www.ibm.com/developerworks/cn/java/j-jodatime.html)

