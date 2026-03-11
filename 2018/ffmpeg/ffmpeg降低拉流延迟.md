ffmpeg

* avformat_find_stream_info方法延迟比较大，修改以下参数可以降低延迟
>probesize<br>
以字节为单位设置探测大小，即要分析的数据大小以获取流信息。如果分散到流中，值越高，检测到的信息越多，但会增加延迟。必须是不小于32的整数。默认情况下为5000000<br>
analyzeduration<br>
指定分析多少微秒来探测输入。较高的值将能够检测到更准确的信息，但会增加延迟。它默认为5,000,000微秒= 5秒

* javacv修改方式

```
  public FFmpegFrameGrabber call() {
        FFmpegFrameGrabber ff;
        try {
            ff = FFmpegFrameGrabber.createDefault(url);
            ff.setFormat("flv");
            ff.setOption("probesize", "2048");
            ff.setOption("max_analyze_duration", "11");
     //设置超时时间 10s
     ff.setOption("stimeout" , "10000000");
            ff.start();
        } catch (Exception e) {
            logger.error("create FFmpegFrameGrabber error", e);
            return null;
        }
        return ff;
    }
```


* max_delay 整数（输入/输出）
> 以微秒为单位设置最大复用或解复用延迟

参考文档：https://ffmpeg.org/ffmpeg-formats.html
