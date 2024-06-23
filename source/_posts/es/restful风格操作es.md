---
title: restful 风格操作es
date: 2024-06-22 00:00:00
---
# restful 风格操作es

| method |                url地址                 |          描述          |
| :----: | :------------------------------------: | :--------------------: |
|  PUT   |     host:port/索引名/类型名/文档ID     | 创建文档（指定文档ID） |
|  POST  |        host:port/索引名/类型名         | 创建文档（随机文档ID） |
|  POST  | host:port/索引名/类型名/文档ID/_update |        修改文档        |
|  POST  | host:port/索引名/类型名/文档ID/_search |        查询数据        |
| DELETE |   host:port/索引名[/类型名][/文档ID]   |        删除文档        |
|  GET   |     host:port/索引名/类型名/文档ID     |   通过文档ID查询文档   |

> 类型：_doc

## 数据类型

| 数据类型 | 关键字                                   |
| -------- | ---------------------------------------- |
| 字符串   | text keyword(不可分词)                   |
| 整数     | long integer short byte                  |
| 浮点数   | double float (half float) (scaled float) |
| 日期     | date                                     |
| 布尔     | boolean                                  |

# PUT

### 创建一个文档

``` 
PUT /test/_doc/doc1
{
	"name":"test"
}
```

![20240623211112](http://img.wanstu.cn/vscode/picgo/20240623211112.png)

### 更新文档

```
PUT /test/_doc/doc1
{
	"name":"更新测试"
}
```

![20240623211120](http://img.wanstu.cn/vscode/picgo/20240623211120.png)

## 指定数据类型创建索引

```
PUT /test1
{
	"mappings" : {
		"properties" : {
			"name" : {
				"type" : "keyword"
			}			
		}
	}
}
```

![20240623211129](http://img.wanstu.cn/vscode/picgo/20240623211129.png)

- 创建索引时，可以设置 字段的 类型 和 分词器

```
PUT /test
{
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "ik_max_word"
      },
      "tags": {
        "type": "keyword"
      }
    }
  }
}
```

![20240623211137](http://img.wanstu.cn/vscode/picgo/20240623211137.png)

# GET

### 获取索引信息

```
 GET test1
```

![20240623211146](http://img.wanstu.cn/vscode/picgo/20240623211146.png)

### 获取健康值

```
GET _cat/health
```

![20240623211225](http://img.wanstu.cn/vscode/picgo/20240623211225.png)
```
GET _cat/indices?v
```
![20240623211215](http://img.wanstu.cn/vscode/picgo/20240623211215.png)




## POST

### 更新文档

```
POST /test/_doc/doc1/_update
{
	"doc" : {
		"name":"更新1测试"
	}
}
```

![20240623211235](http://img.wanstu.cn/vscode/picgo/20240623211235.png)

### 搜索 字段

```
POST /23031625/_doc/_search
{
  "query" : {
    "match" : {
      "content":"裂开"
    }
  }
}
```

![20240623211244](http://img.wanstu.cn/vscode/picgo/20240623211244.png)

 
