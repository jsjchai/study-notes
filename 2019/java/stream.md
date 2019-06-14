* 过滤倒序排序
```java
 List<Integer> nums = Lists.newArrayList(81,34,67,12,90,45);
 List<Integer> list = nums.stream()
                      .filter(e -> e > 50)
                      .sorted(Comparator.comparingInt(Integer::byteValue).reversed())
                      .collect(Collectors.toList());
```
