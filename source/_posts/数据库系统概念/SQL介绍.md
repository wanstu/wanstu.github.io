---
title: SQL介绍
date: 2024-06-22 00:00:00
---
# SQL介绍

SQL 由 IBM 发行，SQL语言分为几个部分

- 数据定义语言
- 数据操纵语言
- 完整性
- 视图定义
- 事务控制
- 嵌入式SQL
- 授权

## SQL数据定义

### 基本类型

- char(n) 定长字符串
- varchar(n) 变长字符串
- int 整数
- numeric(n,m) 具有m为精度的、有效长度为n的浮点型
- real、double precision 浮点数和双精度浮点数，精度依赖于机器
- float(n) 精度为n的浮点数

### 基本模式定义

#### 创建关系 CREATE TABLE

```sql
CREATE TABLE Test
(id int,
test1 varchar(10),
PRIMARY KEY(id));
```

>  CREATE TABLE 的通用形式
>
> ```sql
> CREATE TABLE table_name
> (A1 D1,
> A2 D2,
> <完整性约束1>
> <完整性约束2>);
> ```

SQL支持许多不同的完整性约束。

- PRIMARY KEY(A1,A2,A3,...,An); 主码声明
- FOREIGN KEY(A1,A2,...,An) REFERENCES s; 外码声明

### SQL查询的基本结构

#### 单关系查询

```sql
SELECT field_name
FROM table_name;
```

去除重复值

```sql
SELECT DISTINCT file_name
FROM table_name;
```

#### 多关系查询



