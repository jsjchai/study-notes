## jVM  Command line tool

### jps 虚拟机进程状况工具
```shell
  # 查询进程id并打印主类的全名（如果是jar包启动，则打印jar包路径）
  jps -l
```
### jstat 虚拟机统计信息监视工具
```shell
  #每100毫秒查询一次进程8080垃圾收集状况，一共查询20次
  jstat -gc 8080 100 20
```
### jinfo java配置信息工具
```shell
  #查看进程id47168虚拟机各项参数
  jinfo  47168
```
### jmap java内存映像工具
### jstack java堆栈跟踪工具
### HSDIS JIT生成代码反汇编

