---
title: 记一次使用模板渲染js报错
date: 2024-06-22 00:00:00
---
这个项目是一个较旧的项目 前后端未分离 使用的是 php 框架模板渲染 最近有一个功能 使用的是 json 字符串来进行的数据传递（后端到前端）大概是这个样子

```html
<html>
<!-- h5 部分 略 -->
</html>
<script>
  // 略 
  const data = JSON.parse('{$data}')
  // 略   
</script>
```

>  {$data} 是模板语法 

问题就出在了 `const data = {$data}` 中的 {$data}

假设 `$data` 的值为 '{"text":"测试测试"}'  此时框架编译出的文件是这样

```html
<html>
<!-- h5 部分 略 -->
</html>
<script>
  // 略 
  const data = JSON.parse('{"text":"测试测试"}')
  // 略   
</script>

```

此时没有任何问题

但是如果 $data 的值为 '{"text":"测试\n测试"}' 此时框架在解析这一行时就可能会把 \n 给转译成换行 那这时我们再看这个文件

```html

<html>
<!-- h5 部分 略 -->
</html>
<script>
  // 略 
  const data = JSON.parse('{"text":"测试
测试"}')
  // 略   
</script>


```

发现问题了吗 这时在执行这个 h5 文件时 js就会报错

解决方案是使用正则将所有的 \n 替换成 \\\n

```html
<html>
<!-- h5 部分 略 -->
</html>
<script>
  // 略 
  const data = JSON.parse('{$data}'.replace(/\n/g,'\\n'))
  // 略   
</script>

```

此时我们再看这个文件

```html

<html>
<!-- h5 部分 略 -->
</html>
<script>
  // 略 
  const data = JSON.parse('{"text":"测试\n测试"}')
  // 略   
</script>



```
