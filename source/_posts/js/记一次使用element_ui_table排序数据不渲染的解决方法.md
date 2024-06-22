---
title: 记一次使用element_ui_table排序数据不渲染的解决方法
date: 2024-06-22 00:00:00
---
```javascript
new Sortable(el, {
        animation: 180,
        onEnd({ newIndex, oldIndex }) {
	  // data 数据集
	  // 首先删除旧位置的元素
          const currRow = data.splice(oldIndex, 1)[0]
	  // 将旧位置的元素添加到新的位置
          data.splice(newIndex, 0, currRow)
	  // 深拷贝原数组
          const test = data.slice()
	  // 清空原数组
          data = []
          that.$nextTick(() => {
	    // 为数据集重新赋值
            that.form.interactiveProcessInit = test
            that.$forceUpdate()
          })
        }
      })
```

[参考](https://segmentfault.com/q/1010000009672767)

[nextTick vue 文档](https://cn.vuejs.org/v2/api/#Vue-nextTick)
