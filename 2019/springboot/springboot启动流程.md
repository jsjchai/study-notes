## springboot启动流程
> springboot使用了main方法启动,通过SpringApplication.run加载spring配置

创建springboot应用
```java
@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

}
```
