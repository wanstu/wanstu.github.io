---
title: Java 学习 Day02
date: 2024-06-22 00:00:00
---
# Java 学习 Day02
### 基本数据类型(8种)
- 长整型 long
- 基本整型 int
- 短整型 short
- 字节型 byte
- 字符型 char
- 布尔型 boolean
- 单精度浮点型 float
- 双精度浮点型 double
#### 需要注意的地方
- 使用大数值运算时注意内存溢出问题
- 整型
- 整形数值可以使用下划线分割 如 10_0000
> 整型分 二进制数(0b) 八进制数(0) 十进制数 十六进制数(0x)
>
> |\\|二进制数(0b)|八进制数(0)|十进制数|十六进制数(0x)
> |-|-|-|-|-
> |参考|0b10|010|10|0x10
> |分别代表十进制数中的|2|8|10|16
- 浮点型
> 浮点型数据具有 有限 离散 舍入误差 接近但不等于 的特点，应该避免使用浮点数进行 比较 运算
- 字符型
> 字符型 使用 Unicode码 存储 Unicode码值为16进制，例如
> |Unicode码|字符
> |-|-
> |U+0061|a
> > 对于英文字符 ASCII码 和 Unicode码 是相同的
#### 类型转换
- 自动转换
- 在运算中 不同类型的数据会转换成相同类型的数据再进行运算，自动转换 的顺序位 精度低 -> 高
> byte > short > char > int > long > float > double
##### 需要注意的地方
> - 在进行 强制转换 时 从高精度 -> 低精度转换时 会造成内存溢出/精度损失 转换结果可能会很难预测
> - 不能对布尔类型的进行转换
> - 不能把对象类型转换为不相干的类型
### 变量
- 类变量
- 实例变量
- 局部变量

局部变量：先声明并初始化使用，作用范围是当前方法
实例变量：先声明后使用，使用时需要先将类实例化
> 如果实例变量没有手动初始化就采用默认值
>
> |数据类型|默认值
> |-|-
> |整型|0
> |浮点型|0.0
> |布尔类型|false
> |引用类型|null

类变量：使用 static 修饰的实例变量，先声明后使用，可以在类中直接使用
### 常量
- 使用 final 修饰的变量
- 使用 final 修饰的变量只能初始化不能被赋值