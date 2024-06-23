---
title: TTS + sovits4 使用心得
date: 2023-07-07 16:20:48
tags:
---
#### 工欲善其事必先利其器
> 我们要先做一些准备
>
> [tts 工具地址 ](https://www.text-to-speech.cn/) 有免费额度 很好用
>
> sovits 所用平台：[autodl](https://www.autodl.com)
>
> 关于 autodl 的使用的话我在此不多赘述
>
> 镜像信息
> 
> ![20240623210655](http://img.wanstu.cn/vscode/picgo/20240623210655.png)
>

#### sovits 模型准备
根据镜像作者的提示 先把项目移到 `/root/autodl-tmp/so-vits-svc4`
![20240623210713](http://img.wanstu.cn/vscode/picgo/20240623210713.png)
然后我们到 `/root/autodl-tmp/so-vits-svc4` 目录执行 `python app.py`
等待一会就可以看到启动成功了
> sovits 模型的训练可以参考视频 [【AI翻唱/SoVITS 4.1】手把手教你老婆唱歌给你听~无需配置环境的本地训练/推理教程[懒人整合包]](https://www.bilibili.com/video/BV1H24y187Ko)

#### 音频素材准备
打开TTS文字转语音工具
将准备好的文字转成语音，转换时可以适当添加停顿等，增强真实性的同时会增强 sovits 转换的效果
![20240623210734](http://img.wanstu.cn/vscode/picgo/20240623210734.png)
#### 如何使用
现在我们假设已经有训练好的模型
- 点击 刷新
![20240623210748](http://img.wanstu.cn/vscode/picgo/20240623210748.png)
- 可以看到目前有的模型
![20240623210800](http://img.wanstu.cn/vscode/picgo/20240623210800.png)
- 选择模型后 再选择训练模型时使用的配置文件
![20240623210821](http://img.wanstu.cn/vscode/picgo/20240623210821.png)
-  加载模型 可以看到 模型加载成功的出现
![20240623210836](http://img.wanstu.cn/vscode/picgo/20240623210836.png)
- TS转出的音频上传
![t6AhaxF9neGXBUr.png](https://s2.loli.net/2023/07/07/t6AhaxF9neGXBUr.png)
- 的参数选项 会对生成的音频效果有很大影响 如果是人干声的话可以打开 自动f0预测 下面的 变调（整数，可以正负，半音数量，升高八度就是12） 可以调整 音色
![20240623210848](http://img.wanstu.cn/vscode/picgo/20240623210848.png)
- 点击下面的 音频转换
正常情况下就可以得到结果了
![20240623210900](http://img.wanstu.cn/vscode/picgo/20240623210900.png)
随后我们可以再根据生成声音的质量等调整参数与源音频的参数 重复上述步骤
