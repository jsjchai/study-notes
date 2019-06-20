# AtomicReferenceFieldUpdater用法

## AtomicIntegerFiledUpdater的引入，在不修改用户代码（调用方）的情况下，就能实现并发安全性

```java
@ToString
public class Account {
    private volatile int money;

    // 引入AtomicIntegerFieldUpdater,保证原子性
    private static final AtomicIntegerFieldUpdater<Account> updater = AtomicIntegerFieldUpdater.newUpdater(Account.class, "money");

    Account(int money) {
        this.money = money;
    }

    public void increMoney() {
        //money++ 不是线程安全的
        updater.incrementAndGet(this);
    }

    public int getMoney() {
        return money;
    }

    public static void main(String[] args) throws InterruptedException {
        Account account = new Account(0);

        List<Thread> list = new ArrayList<>();
        for (int i = 0; i < 100; i++) {
            Thread t = new Thread(account::increMoney);
            list.add(t);
            t.start();
        }

        for (Thread t : list) {
            t.join();
        }

        System.out.println(account.toString());
    }
}
```
## AtomicIntegerFiledUpdate
```java
   //java11 AtomicIntegerFiledUpdate.class
   public final int incrementAndGet(T obj) {
            return getAndAdd(obj, 1) + 1;
   }
    public final int getAndAdd(T obj, int delta) {
            //检查obj是否是tclass的实例对象，否则抛出AccessCheckException异常
            accessCheck(obj);
            return U.getAndAddInt(obj, offset, delta);
    }
    
    //Unsafe.class
    @HotSpotIntrinsicCandidate
    public final int getAndAddInt(Object o, long offset, int delta) {
        int v;
        do {
            v = getIntVolatile(o, offset);
        } while (!weakCompareAndSetInt(o, offset, v, v + delta));
        return v;
    }
```

## 参考文档
* [Java多线程进阶（十六）—— J.U.C之atomic框架：FieldUpdater](https://segmentfault.com/a/1190000015864724)

