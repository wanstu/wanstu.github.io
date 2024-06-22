---
title: logstash date 插件
date: 2024-06-22 00:00:00
---
# logstash date 插件

- date 插件是日期插件，可用配置如下

| 设置           | 输入类型 | 是否为必填 | 默认值                | 解释 |
| -------------- | -------- | ---------- | --------------------- | ---- |
| add_field      | hash     | No         | {}                    |      |
| add_tag        | array    | No         | []                    |      |
| locale         | string   | No         |                       |      |
| match          | array    | No         | []                    |      |
| periodic_flush | boolean  | No         | false                 |      |
| remove_field   | array    | No         | []                    |      |
| remove_tag     | array    | No         | []                    |      |
| tag_on_failure | array    | No         | ["_dateparsefailure"] |      |
| target         | string   | No         | "@timestamp"          |      |
| timezone       | string   | No         |                       |      |

> 其中，add_field、remove_field、add_tag、remove_tag 是所有 Logstash 插件都有。它们在插件过滤成功后生效。