---
title: 高数一导数
tags:
---
# 导数
## 基本公式
$\lim\limits_{\Delta x \to 0} f^{'}(x_0) = \frac{f(x_0 + \Delta x) - f(x_0)}{\Delta x}$
## 求导
### 常见求导公式

1. *<mark>$(c)^{'} = 0$</mark>
2. *<mark>$(x^a)^{'} = ax^{a-1}$</mark>
3. <mark>$(log_ax)^{'} = \frac{1}{xlina}$</mark>
4. *<mark>$(lnx)^{'} = \frac{1}{x}$</mark>
   > $(lnC)^{'} = 0$ **ln常数的导数为0**
5. <mark>$(a^x)^{'} = a^xlna$</mark>
6. *<mark>$(e^x)^{'} = e^x$</mark>
7. *<mark>$(sinx)^{'} = cosx$</mark>
8. *<mark>$(cosx)^{'} = -sinx$</mark>
9.  \*$(tanx)^{'} = sec^2x$
10. $(cotx)^{'} = -csc^2x$
11. \*$(arcsinx)^{'} = \frac{1}{\sqrt{1 - x^2}}$
12. $(arccosx)^{'} = -\frac{1}{\sqrt{1-x^2}}$
13. \*$(arctanx)^{'} = \frac{1}{1 + x^2}$
14. $(arccotx)^{'} = -\frac{1}{1 + x^2}$
15. $(secx)^{'} = secx * tanx$
16. $(cscx)^{'} = -cscx * cotx$
> 特殊的公式
17. \*<mark>$(Cu)^{'} = C(u)^{'}$</mark>
   > 常数可以提取出来
18.  <mark>$(\frac{1}{x})^{'} = (x^{-1})^{'} = -x^{-2} = -\frac{1}{x^2}$</mark>
19.  <mark>$(\sqrt{x})^{'} = (x^\frac{1}{2})^{'} = \frac{1}{2}x^{(-\frac{1}{2})} = \frac{1}{2(\sqrt{x})}$</mark>
> \* 标记的重点记
## 运算法则
- <mark>和差的导数等于导数的和差</mark>
  $(u \pm v)^{'} = (u)^{'} \pm (v)^{'}$
- <mark>积的导数等于前导后不导加上前不导后导</mark>
  $(kv)^{'} = (k)^{'}v + k(v)^{'}$
- <mark>商的导数等于上导下不导减上不导下导除以下的平方</mark>
  $(\frac{u}{v})^{'} = \frac{(u)^{'}v - u(v)^{'}}{v^2}$

# <mark>复合函数求导</mark>
## 定义
$y = sinx$ 和 $y=x^2$ 属于基本函数
但是 $y = sinx^2$ 是复合函数 $y = t^2$ & $t=sinx$
## 求导
1. 假设
2. 分别求导
3. 回代

eg:
$y = sin t$ & $t = x^2$
$y^{'} = \frac{\delta y}{\delta x} = \frac{\delta y}{\delta t} * \frac{\delta t}{\delta x} $
$ = (sint)^{'} * (x^2)^{'} = const * 2x = 2x * cos x^2 $

# 微分方程
$y^{'} = \frac{\delta y}{\delta x}$

<mark>$\delta y = y^{'} * \delta x$</mark>
