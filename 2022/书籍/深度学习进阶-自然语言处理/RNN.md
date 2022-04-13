## 循环神经网络 RNN
> 循环神经网络（Recurrent Neural Network, RNN）是一类以序列（sequence）数据为输入，在序列的演进方向进行递归（recursion）且所有节点（循环单元）按链式连接的递归神经网络（recursive neural network）

![image](https://user-images.githubusercontent.com/13389058/159152197-ccef9fa0-054e-4ad4-a676-0794c82cb1b0.png)


### 语言模型（language model）
> 由P（wt|w1,···, wt-1）表示的模型称为条件语言模型（conditionallanguage model），有时也将其称为语言模型
* 语言模型（language model）给出了单词序列发生的概率。具体来说，就是使用概率来评估一个单词序列发生的可能性，即在多大程度上是自然的单词序列
* 使用语言模型，可以按照“作为句子是否自然”这一基准对候选句子进行排序
* 语言模型也可以用于生成新的句子
* 语言模型将单词序列解释为概率

### 马尔可夫性
> 马尔可夫性是指未来的状态仅依存于当前状态。此外，当某个事件的概率仅取决于其前面的N个事件时，称为“N阶马尔可夫链”。

### word2vec与RNN
* CBOW模型还存在忽视了上下文中单词顺序的问题
* RNN具有一个机制，那就是无论上下文有多长，都能将上下文信息记住
* word2vec是以获取单词的分布式表示为目的的方法，因此一般不会用于语言模型

### 特征
* RNN的特征就在于拥有这样一个环路（或回路）。这个环路可以使数据不断循环。通过数据的循环，RNN一边记住过去的数据，一边更新到最新的数据
 <img src="https://user-images.githubusercontent.com/13389058/157156221-2ce10bbc-8349-45f0-959c-3b8e099fd05d.png" width="50%" height="50%">

### 公式
> 各个时刻的RNN层接收传给该层的输入和前一个RNN层的输出，然后据此计算当前时刻的输出，此时进行的计算可以用下式表示：**h<sub>t</sub>=tanh(h<sub>t-1</sub>W<sub>h</sub>+x<sub>t</sub>W<sub>x</sub>+b)**
* 时刻t的输入数据为x<sub>t</sub>
* RNN有两个权重，分别是将输入x转化为输出h的权重W<sub>x</sub>和将前一个RNN层的输出转化为当前时刻的输出的权重W<sub>h</sub>
* 偏置b
* ht-1和xt都是行向量
* tanh函数（双曲正切函数)
* 将RNN的输出h<sub>t</sub>称为隐藏状态（hidden state）或隐藏状态向量（hidden state vector）

### 基于时间的反向传播 BPTT
> 按时间顺序展开的神经网络的误差反向传播法,可以通过先进行正向传播，再进行反向传播的方式求目标梯度
* 随着时序数据的时间跨度的增大，BPTT消耗的计算机资源也会成比例地增大(内存)
* 反向传播的梯度也会变得不稳定
* 随着时序数据变长，计算机的内存使用量（不仅仅是计算量）也会增加
* 在学习长时序数据时,要生成长度适中的数据块,进行以块为单位的BPTT学习

### 截断的BPTT (Truncated BPTT)
> 将时间轴方向上过长的网络在合适的位置进行截断，从而创建多个小型网络，然后对截出来的小型网络执行误差反向传播法. Truncated BPTT是指按适当长度截断的误差反向传播法
* 在RNN执行Truncated BPTT时,数据需要按顺序输入,不是随机的
* Truncated BPTT只截断反向传播的连接

### Truncated BPTT的mini-batch学习
#### 数据的输入方法
1. 要按顺序输入数据;
2. 要平移各批次(各样本)输入数据的开始位置

### RNN的实现
1. 实现进行单步处理的RNN类;
2. 利用这个RNN类,完成一次进行T步处理的Time RNN类

### Time RNN的实现
> Time RNN层由T个RNN层构成
![image](https://user-images.githubusercontent.com/13389058/159152696-97672918-290d-4785-8284-0468981270cd.png)
* 参数stateful 指定是否保存上一时刻的隐藏状态


### 处理时序数据的层的实现
* RNNLM 基于RNN的语言模型

![image](https://user-images.githubusercontent.com/13389058/159152987-1d62208c-8c85-405d-8fec-b3d544695caf.png)

1. 按顺序生成mini-batch
2. 调用模型的正向传播和反向传播
3. 使用优化器更新权重
4. 评价困惑度

### 语言模型的评价
* 困惑度 评价语言模型的预测性能的指标
   * 困惑度表示概率的倒数
   * 困惑度越小越好
* 分叉度 指下一个可以选择的选项的数量(下一个可能出现的单词候选个数)
* 理论上,使用RNN层的条件语言模型可以记忆所有已出现单词的信息

![image](https://user-images.githubusercontent.com/13389058/159153130-69e88dfe-2132-4877-86a6-44c202ed95c9.png)

* 假设数据量为N个。t<sub>n</sub>是one-hot向量形式的正确解标签，t<sub>nk</sub>表示第n个数据的第k个值，y<sub>nk</sub>表示概率分布（神经网络中的Softmax的输出）L是神经网络的损失，使用这个L计算出的e<sup>L</sup>就是困惑
