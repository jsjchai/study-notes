使用guava的Preconditions做参数校验
```java
    public static void checkAge(int num){
        Preconditions.checkArgument(num > 11,"param illegal age=%s",num);
    }
```
