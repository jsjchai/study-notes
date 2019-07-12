```java
@PostMapping(value = "/getById",produces="application/x-www-form-urlencoded;charset=UTF-8")
```

### @RequestParam

* 简单类型数据绑定（String->Integer等）
* 处理Content-Type=application/x-www-form-urlencoded的get或post请求
* 请求参数格式一般是a=1&b=3

### @RequestBody
* 处理Content-Type不是application/x-www-form-urlencoded类型的请求，如：application/json、application/xml等
* json格式会自动封装成实体类
