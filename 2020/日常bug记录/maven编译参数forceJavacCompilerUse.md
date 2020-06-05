**报错信息**
```
执行mvn编译，报错信息如下：
Exception in thread "main" java.lang.AssertionError
```
**参考链接**

[Maven compilation issue with Java 9](https://stackoverflow.com/questions/46878649/maven-compilation-issue-with-java-9)

**解决办法**
```
mvn compile -Dmaven.compiler.forceJavacCompilerUse=true
```
