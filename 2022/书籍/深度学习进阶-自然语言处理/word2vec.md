## word2vec
### 基于推理的方法
> 基于推理的方法引入了某种模型,将神经网络用于此模型.这个模型接收上下文信息作为输入,并输出(可能出现的)各个单词的出现频率.在这样的框架中,使用语料库来学习模型,使之能做出正确的预测
* 基于推理的方法是使用神经网络,通常在mini-batch数据上进行学习.
* 基于推理的方式使用部分学习数据逐步学习
* you ? goodbye and I say hello.
  * 预测“?”处出现什么单词,这就是推理 
* 分布式假设
#### one-hot向量
* 要用神经网络处理单词,需要将单词转化为固定长度的向量,一种方式是将单词转化为one-hot表示
* 在one-hot表示中,只有一个元素是1,其他元素都是0
### word2vec常用的神经网络模型
* CBOW模型
* skip-gram模型
### CBOW模型
> CBOW模型是根据上下文预测目标词的神经网络("目标词"是指中间的单词,它周围的单词是“上下文”)
* 从多个单词(目标词)预测1个单词(上下文)

![image](https://user-images.githubusercontent.com/13389058/161190984-5f45a7d9-7d47-4b57-b463-49a3cf53a76b.png)

### skip-gram模型
* skip-gram是反转了CBOW模型处理的上下文和目标词的模型
* 从1个单词(目标词)预测多个单词(上下文)

![image](https://user-images.githubusercontent.com/13389058/161191030-d4e4c52f-6b67-4b9b-a1fc-d0d11021a34a.png)

* 从单词的分布式表示的准确度来看,在大多数情况下,skip-gram模型的结果更好.特别是随着语料库规模的增大,在低频词和类推问题的性能方面,skip-gram模型往往会有更好的表现
### GloVe方法
* GloVe方法融合了基于推理的方法和基于计数的方法
