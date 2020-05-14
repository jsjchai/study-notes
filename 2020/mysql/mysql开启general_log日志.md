
## MySQL开启general_log 跟踪数据执行过程
**注意在Linux中只能设置到 /tmp 或 /var 文件夹下，设置其他路径出错**
1. 设置general log保存路径
```shell
mysql>set global general_log_file='/tmp/general.log'; 
```
2. 开启general log模式
```shell
 mysql>set global general_log=on; 
```
3. 关闭general log模式
```shell
 mysql>set global general_log=off; 
```
