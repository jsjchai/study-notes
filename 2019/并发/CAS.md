### CAS
> CAS比较并交换，CAS包含3个操作数-需要读写内存位置V、进行比较的值A和拟写入的新值B。当且仅当V的值等于A时，CAS才会通过原子方式用新值B
来更新V的值，否则不会执行任何操作。
```java
        AtomicInteger num = new AtomicInteger(10);

        new Thread(() -> {
            System.out.println("thread:" + num.compareAndSet(10, 20) + " num:" + num.get());
        }).start();

        System.out.println("main:" + num.compareAndSet(10, 21)+ " num:" + num.get());
```
