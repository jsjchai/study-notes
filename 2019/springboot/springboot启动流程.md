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
调用SpringApplication.run时，会初始化一个SpringApplication对象
```java
public static ConfigurableApplicationContext run(Class<?>[] primarySources,
			String[] args) {
		return new SpringApplication(primarySources).run(args);
}
```
在SpringApplication会加载一些默认配置
```java
public SpringApplication(ResourceLoader resourceLoader, Class<?>... primarySources) {
		this.resourceLoader = resourceLoader;
		Assert.notNull(primarySources, "PrimarySources must not be null");
		this.primarySources = new LinkedHashSet<>(Arrays.asList(primarySources));
        //判断应用类型，通过jar包依赖项判断应用类型SERVLET、REACTIVE、NONE，默认是SERVLET类型
		this.webApplicationType = WebApplicationType.deduceFromClasspath();
        //获取ApplicationContextInitializer实现类集合，如：RestartScopeInitializer
		setInitializers((Collection) getSpringFactoriesInstances(ApplicationContextInitializer.class));
        //获取ApplicationListener实现类集合,如：RestartApplicationListener、LoggingApplicationListener
		setListeners((Collection) getSpringFactoriesInstances(ApplicationListener.class));
		this.mainApplicationClass = deduceMainApplicationClass();
}
```
![images](https://github.com/jsjchai/study-notes/blob/master/2019/springboot/images/ApplicationContextInitializer%E5%AE%9E%E7%8E%B0%E7%B1%BB.jpg)

