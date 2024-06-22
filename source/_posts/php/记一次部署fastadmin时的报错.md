---
title: 记一次部署fastadmin时的报错
date: 2024-06-22 00:00:00
---
lang 总是执行出错

Uncaught Error: Script error for "lang", needed by: fast

Failed to load resource: the server responded with a status of 404 (Not Found)

![](https://www.helloimg.com/images/2022/07/26/Zw4YfK.png)

![](https://www.helloimg.com/images/2022/07/26/Zw4hqb.png)
通过修改伪静态解决

```
if (!-e $request_filename) {
    rewrite ^(.+?\.php)(/.+)$ /$1?s=$2 last;
    rewrite ^(.*)$ /KveacRZAzp.php?s=$1 last;
    break;
}
```

> KveacRZAzp 是随机生成的入口名
