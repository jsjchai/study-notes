### Apache Hadoop
>Apache Hadoop是一个开源框架，允许使用简单的编程模型在跨计算机集群的分布式环境中存储和处理大数据。它旨在从单个服务器扩展到数千台计算机，每台计算机都提供本地计算和存储。

### Apache hadoop有哪些优点
  * 能够快速存储和处理大量任何类型的数据
  * 计算能力
  * 容错
  * 灵活性
  * 低成本
  * 可扩展性

### Apache hadoop核心模块

#### HDFS 分布式文件系统
![image](https://hadoop.apache.org/docs/r3.2.0/hadoop-project-dist/hadoop-hdfs/images/hdfsarchitecture.png)
> HDFS可能由成百上千的服务器所构成，每个服务器上存储着文件系统的部分数据。HDFS采用master/slave架构。一个HDFS集群是由一个Namenode和一定数目的Datanodes组成。

* namenode
> 主节点,负责管理文件系统的名字空间(namespace)以及客户端对文件的访问,存储文件元数据（文件名、目录结构以及每个文件的Block和Block所属的datanode信息等）
* secondaryNameNode
> 辅助namenode进行管理
* datanode
> 用户数据存储,被namenode管理，定时向namenode发送节点状态，执行namenode分配分发的任务

#### Hadoop MapReduce 分布式计算
> 分布式计算将该应用分解成许多小的部分，分配给多台计算机进行处理。Hadoop Map/Reduce是一个使用简易的软件框架，基于它写出来的应用程序能够运行在由上千个商用机器组成的大型集群上，并以一种可靠容错的方式并行处理上T级别的数据集。
Map/Reduce框架由一个单独的master JobTracker 和每个集群节点一个slave TaskTracker共同组成。master负责调度构成一个作业的所有任务，这些任务分布在不同的slave上，master监控它们的执行，重新执行已经失败的任务。而slave仅负责执行由master指派的任务。

#### Hadoop YARN 资源管理和作业调度
![image](http://hadoop.apache.org/docs/r3.2.0/hadoop-yarn/hadoop-yarn-site/yarn_architecture.gif)
> 控制整个集群并管理应用程序向基础计算资源的分配，由ResourceManager和NodeManager构成。ResourceManager是在系统中的所有应用程序之间仲裁资源的最终权限。NodeManager是每台机器框架代理，负责容器，监视其资源使用情况（CPU，内存，磁盘，网络）并将其报告给ResourceManager / Scheduler。
每个应用程序ApplicationMaster实际上是一个特定于框架的库，其任务是协调来自ResourceManager的资源，并与NodeManager一起执行和监视任务。

#### Hadoop Common
> 支持其他Hadoop模块的常用实用程序

### 参考文档
* [Apache Hadoop 3.2.0](https://hadoop.apache.org/docs/r3.2.0/index.html)
