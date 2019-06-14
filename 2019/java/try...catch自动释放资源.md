
> 从 Java 7 build 105 版本开始，Java 7 的编译器和运行环境支持新的 try-with-resources 语句，称为 ARM 块(Automatic Resource Management) ，自动资源管理

```java
 List<String> data = new ArrayList<String>();
 try (BufferedReader br = new BufferedReader(new FileReader(file))) {
   String line;
   while ((line = br.readLine()) != null) {
     data.add(line);
   }
 } catch (IOException e) {
   e.printStackTrace();
 }
```

上面代码中，数据流会在 try 执行完毕后自动被关闭，前提是，这些可关闭的资源必须实现 java.lang.AutoCloseable 接口
