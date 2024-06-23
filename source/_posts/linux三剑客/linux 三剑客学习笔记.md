---
title: 三剑客学习使用
date: 2024-06-22 00:00:00
---
# Linux 三剑客学习使用



| 工具 |           特点           |              使用场景              |
| :--: | :----------------------: | :--------------------------------: |
| grep |           过滤           |             过滤速度快             |
| sed  | 替换，修改文件内容，取行 | 文件修改，或取出某个**范围**的内容 |
| awk  |      取列，统计计算      |        取列，比较，统计计算        |



## grep

常用命令

| 参数 |                含义                | 备注 |
| :--: | :--------------------------------: | ---- |
|  -E  |   相当于 egrep 命令 支持扩展正则   |      |
|  -c  |           count 统计行数           |      |
|  -v  |             取反 排除              |      |
|  -n  |              显示行号              |      |
|  -i  |          过滤时忽略大小写          |      |
|  -w  |              精确匹配              |      |
|  -A  |   after -An 显示匹配成功后的 n行   | 了解 |
|  -B  |  before -Bn 显示匹配成功前的 n行   | 了解 |
|  -C  | content -Cn 显示匹配成功前后的 n行 | 了解 |

## sed

| 选项 | 解释                     |
| ---- | ------------------------ |
| -n   | 仅显示script处理后的结果 |

### 功能

| 功能  |                                   |
| ----- | --------------------------------- |
| s     | sub 替换 "s#string1#string2#g" 改 |
| p     | print 输出 查                     |
| d     | delete 删除 删                    |
| c/a/i | insert 插入 增                    |

### 执行过程

> 找谁 干啥
>
> 找谁：目标行
>
> 干啥：操作
>
> - 如果想对文件操作，需要使用 -i 参数

![20240623211354](http://img.wanstu.cn/vscode/picgo/20240623211354.png)


### sed 查找（查）

| 格式               | 作用                                       | 修饰符 |
| ------------------ | ------------------------------------------ | ------ |
| "np"               | 指定行号（n）过滤                          | p      |
| "n,mp"             | 指定行号范围[n，m]过滤                     | p      |
| "/string/p"        | 过滤某字符（string） 可以使用正则表达式    | p      |
| "/10:00/,/11:00/p" | 过滤从10点开始11点结束的内容(过滤日志常用) | p      |
| "n,/string/p"      | 混合使用 从第n行开始，到出现string的行结束 | p      |

> 注意：
>
> - 需要使用 -n 参数，否则默认输出会输出所有的行
> - 使用扩展正则需要加 -r 参数
>
> - 在进行范围过滤时，如果结束匹配不到，就会一直找到最后一行

### sed 删除（删）

| 格式               | 作用                                             | 修饰符 |
| ------------------ | ------------------------------------------------ | ------ |
| "nd"               | 指定行号（n）删除                                | d      |
| "n,md"             | 指定行号范围[n，m] 删除                          | d      |
| "/string/d"        | 删除 某字符（string）所在的行 可以使用正则表达式 | d      |
| "/10:00/,/11:00/d" | 删除 从10点开始11点结束的内容(过滤日志常用)      | d      |
| "n,/string/d"      | 混合使用 从第n行开始，到出现string的行结束       | d      |

> 用法与查找类似
>
> - 不需要使用 -n 参数
>
> - 常用  "nd"  "n,md"

### sed 新增（增）

| 格式        | 作用                                | 修饰符 |
| ----------- | ----------------------------------- | ------ |
| "na string" | append 追加 在第n行后追加内容string | a      |
| "nc string" | replace 替换 用string替换第n行      | c      |
| "ni string" | insert 插入 在第n行前插入内容string | i      |

> 增删改查的查找部分类似 
>
> 如 "n,mp" "n,md" "n,ma" "n,ms"

### sed 替换（改）

| 格式                  | 作用                                     | 修饰符 |
| --------------------- | ---------------------------------------- | ------ |
| "s/stringa/stringb/g" | sub 替换 将所有的 stringa 替换为 stringb | s      |
|                       | 表示行内全面替换。                       | g      |

> 其中 / 是分界符,可以使用 ：@  # 等
>
> - "s/stringa//g" 这个用法可以使stringa替换为空，达成删除的效果

#### 后向引用（反向引用）[扩展正则]

>  先保护再使用

![20240623211404](http://img.wanstu.cn/vscode/picgo/20240623211404.png)

总结

![20240623211410](http://img.wanstu.cn/vscode/picgo/20240623211410.png)

## awk

### 执行过程

![20240623211419](http://img.wanstu.cn/vscode/picgo/20240623211419.png)

### 内置变量

| 变量                | 解释                                                  | 用法                            |
| ------------------- | ----------------------------------------------------- | ------------------------------- |
| NR                  | number of record 指定行号( ==  != < <= >  >= )        | (NR==1) \| (NR >= 1 && NR <= 5) |
| NF                  | number of field 每行的列数                            | $NF  最后一列                   |
| FS                  | field separator 字段分隔符 相当于 -F ,-F: === -v FS=: | 字段分隔符                      |
| OFS                 | output field separator                                | 输出字段分隔符                  |
| /string/            | 过滤 string 所在的行                                  |                                 |
| /string1/,/string2/ | 从 string1 所在的行开始到 string2所在的行             |                                 |



### 行与列

|      |                | 备注                       |
| ---- | -------------- | -------------------------- |
| 行   | record 记录    | 每一行**默认**以换行结尾   |
| 列   | field 字段\|域 | 每一列**默认**以空格和制表 |

#### 行

使用内置变量 NR 按行过滤

#### 列

使用 **-F**指定列的分隔符

使用 $n 取出第n列数据

> 练习：
>
> -  取出网卡IP地址
>
> ![20240623211431](http://img.wanstu.cn/vscode/picgo/20240623211431.png)
>
> - 解析nginx日志，得到返回状态不是200的请求信息（状态码 IP 请求类型 请求url )
>
> ![20240623211450](http://img.wanstu.cn/vscode/picgo/20240623211450.png)

## awk 模式匹配



#### 正则的使用

- 使用 ~// 使用正则表达式
![20240623211500](http://img.wanstu.cn/vscode/picgo/20240623211500.png)

```shell
wanqq@DESKTOP-QL4SAK6:/mnt/d/study/nginx/logs/parsing-record$ cat access.log | awk -F" +" 'BEGIN{print "状态码 IP 请求类型 请求url"} NR < 20 && ($9~/[^23][0-9]{2}/) {print $9,$1,$6,$7}' | sed 's#"##' | column -t
状态码  IP          请求类型  请求url
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
404     172.17.0.1  GET       /pushParsingXMLTask
404     172.17.0.1  GET       /pushParsingXMLTask
404     172.17.0.1  GET       /pushParsingXMLTask
500     172.17.0.1  GET       /index/loadFiles/path/app()-%3EgetRootPath().%22public/static/recordXML/%22
404     172.17.0.1  GET       /index/loadFiles/path/app()-%3EgetRootPath().%22public/static/recordXML/%22
```



![20240623211524](http://img.wanstu.cn/vscode/picgo/20240623211524.png)
- 使用 //,// 来限制范围

```shell
wanqq@DESKTOP-QL4SAK6:/mnt/d/study/nginx/logs/parsing-record$ head -10 access.log
172.17.0.1 - - [06/Jan/2022:02:11:57 +0000] "GET / HTTP/1.1" 500 5 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:11:58 +0000] "GET / HTTP/1.1" 500 5 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:13:05 +0000] "GET / HTTP/1.1" 500 5 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:13:06 +0000] "GET / HTTP/1.1" 500 5 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:16:14 +0000] "GET / HTTP/1.1" 200 27 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:16:14 +0000] "GET /favicon.ico HTTP/1.1" 200 1150 "http://localhost:8004/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:17:38 +0000] "GET /pushParsingXMLTask HTTP/1.1" 404 6858 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:18:10 +0000] "GET /pushParsingXMLTask HTTP/1.1" 404 6858 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:18:18 +0000] "GET /pushParsingXMLTask HTTP/1.1" 404 62810 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
172.17.0.1 - - [06/Jan/2022:02:18:31 +0000] "GET /index/pushParsingXMLTask HTTP/1.1" 200 16941 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
wanqq@DESKTOP-QL4SAK6:/mnt/d/study/nginx/logs/parsing-record$ cat access.log | awk -F" +" 'BEGIN{print "状态码 IP 请求类型 请求url"} /\[06\/Jan\/2022:02:11:57 \+0000\]/,/02:13:06/ && ($9~/[^23][0-9]{2}/) {print $9,$1,$6,$7}' | sed 's#"##' | column -t
状态码  IP          请求类型  请求url
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
500     172.17.0.1  GET       /
```


![20240623211533](http://img.wanstu.cn/vscode/picgo/20240623211533.png)

- 特殊模式

  

| 模式     |                         | 应用场景                                                     |
| -------- | ----------------------- | ------------------------------------------------------------ |
| BEGIN    | 在 awk 读取文件之前执行 | 1 简单的统计计算，不涉及读取文件 <br />2 在处理文件之前添加表头 <br />3 创建变量（不如 -v） |
| **END=** | 在 awk 读取文件之后执行 | 1 在awk统计时<span style="color:#66ccff"> **先计算 后在 END 输出结果** </span> 使用数组，输出数组的结果 |

- END 统计计算

- 统计方法 ++（计数） += （求和）

  
