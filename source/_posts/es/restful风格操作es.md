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

![image-20220106164558013](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106164558013.png)

### 更新文档

```
PUT /test/_doc/doc1
{
	"name":"更新测试"
}
```

![image-20220106172051965](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106172051965.png)

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

![image-20220106165647716](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106165647716.png)

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

![image-20220107094211268](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220107094211268.png)

# GET

### 获取索引信息

```
 GET test1
```

![image-20220106170007996](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106170007996.png)

### 获取健康值

```
GET _cat/health
```

![image-20220106170814673](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106170814673.png)

```
GET _cat/indices?v
```

![image-20220106170921309](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106170921309.png)



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

![image-20220106172205021](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106172205021.png)

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

![image-20220106180108316](https://gitee.com/w_c_y_929/extra_bed/raw/master/image-20220106180108316.png)

 
