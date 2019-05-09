### JDK8 Memory Model
#### 运行时数据区
* 堆
 > 堆是所有Java虚拟机线程之间共享的内存区域。它是在虚拟机启动时创建的。所有类实例和数组都在堆中分配（使用new运算符）
* 方法区
 > 所有Java虚拟机线程之间共享的内存。它是在虚拟机启动时创建的，由类加载器从字节码加载。只要加载它们的类加载器处于活动状态，方法区域中的数据就会保留在内存中。在JDK 8中，永久代被删除，类元数据在本机内存中分配。默认情况下，可用于类元数据的本机内存量是无限制的。使用该选项MaxMetaspaceSize可以为用于类元数据的本机内存量设置上限。方法区存储以下信息：
     -  类信息（字段/方法的数量，超类名称，接口名称，版本......）
     -  方法和构造函数的字节码
     -  每个类加载的运行时常量池
 
* 虚拟机栈
* 本地方法栈

#### 参考文档
  * [Java Memory Management](https://dzone.com/articles/java-memory-management)
  * [JVM memory model](http://coding-geek.com/jvm-memory-model/)
