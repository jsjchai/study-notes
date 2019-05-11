### JDK8 Memory Model
#### 运行时数据区
* 堆（Heap）
 > 堆是所有Java虚拟机线程之间共享的内存区域。它是在虚拟机启动时创建的。所有类实例和数组都在堆中分配（使用new运算符）。垃圾收集器管理的主要区域，可细分为新生代、老年带、Eden区、Form Survivor区、To Survivor区等。堆可以动态扩展或收缩，可以通过" -Xms -Xmx"控制其大小，在物理上处于不连续空间，只要逻辑上连续即可。
* 方法区（Method area）
 > 所有Java虚拟机线程之间共享的内存。它是在虚拟机启动时创建的，由类加载器从字节码加载。只要加载它们的类加载器处于活动状态，方法区域中的数据就会保留在内存中。在JDK 8中，永久代被删除，HotSpot将方法区域存储在元空间（Metaspace）的独立本机内存空间中。默认情况下，可用于类元数据的本机内存量是无限制的。使用该选项MaxMetaspaceSize可以为用于类元数据的本机内存量设置上限。方法区存储以下信息：
 
     1. 类信息（字段/方法的数量，父类名称，接口名称，版本......）
     2. 方法和构造函数的字节码
     3. 每个类加载的运行时常量池
* 运行时常量池（Runtime constant pool）
> 方法区的一部分。用于存放编译期生成的各种字面量和符号应用
* 程序计数器（The pc Register (Per Thread)）
> 每个线程都有自己的pc(程序计数器)寄存器，与线程同时创建。字节码解释器工作时就是通过改变这个计数器的值来选取下一条需要执行的字节码指令，分支、循环、跳转、异常处理、线程恢复等基础功能都需要依赖这个计数器完成。可以看作是当前线程所执行的字节码的行号指示器。
* java虚拟机栈（Java Virtual Machine Stacks (Per Thread)）
> 每个线程私有的，生命周期与线程相同。每个方法在执行的同时都会创建一个栈帧用于存储局部变量表、操作数栈、动态链接、方法出口等信息
   * 栈帧（Stack Frame）
     栈帧是一个包含多个数据的数据结构，这些数据代表当前方法(被调用的方法)中线程的状态:
     * 调用栈（Operand Stack）  用于在（java）方法调用中传递参数，并在调用方法的堆栈顶部获取被调用方法的结果
     * 局部变量数组（Local variable array）  这个数组包含当前方法范围内的所有局部变量。这个数组可以保存基本类型、引用或返回地址。此数组的大小在编译时  计算。Java虚拟机使用局部变量在方法调用时传递参数，被调用方法的数组由调用方法的Operand Stack创建。
     * 运行时常量引用（Run-time constant pool reference） 当前类当前方法的常量池对象引用，jvm运行时，指向真实的内存地址   
* 本地方法栈(Native method stack (Per Thread))
> 使用非Java语言编写并通过JNI调用的本机代码堆栈。因为它是一个native方法的堆栈，所以这个堆栈的行为完全依赖于底层操作系统。

#### 参考文档
  * [Java Memory Management](https://dzone.com/articles/java-memory-management)
  * [JVM memory model](http://coding-geek.com/jvm-memory-model/)
