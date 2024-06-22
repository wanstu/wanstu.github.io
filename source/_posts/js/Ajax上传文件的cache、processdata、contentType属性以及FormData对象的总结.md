---
title: Ajax上传文件的cache、processdata、contentType属性以及FormData对象的总结
date: 2024-06-22 00:00:00
---
[原文地址](https://blog.csdn.net/qq_41564928/article/details/90580375)

> 如果要用 Ajax 上传文件，则需要使用 FormData 对象来作为数据，而不能使用 form 的 serialize 方法（原因是 serialize 方法得到的数据是一个字符串，其不支持二进制数据传输，因此无法上传文件）

## formData对象

```
	var formdata = new FormData();//创建一个新的FormData对象
	//Ajax中的 data 属性就是 formdata
	formdata.append('name','value'); //使用append的方法为 formdata 对象赋值
	$.ajax({
            type:'post',
            url:'url',
            contentType:false,
            processData:false,
            cache:false,
            data:formdata,
            success:function(res){
                    console.log('success');
            }
        })
```

## ajax属性：cache、processData、contentType

- cache：缓存
  当发起一次请求后，会把获得的结果以缓存的形式进行存储，当再次发起请求时，如果 cache 的值是 true ，那么会直接从缓存中读取，而不是再次发起一个请求了。
  从 cache 的工作原理可以得出，cache 的作用一般只在 get 请求中使用。
- processData：处理数据
  默认情况下，processData 的值是 true，其代表以对象的形式上传的数据都会被转换为字符串的形式上传。而当上传文件的时候，则不需要把其转换为字符串，因此要改成false
- contentType：发送数据的格式
  和 contentType 有个类似的属性是 dataType ， 代表的是期望从后端收到的数据的格式，一般会有 json 、text……等

  - 而 contentType 则是与 dataType 相对应的，其代表的是 前端发送数据的格式
  - 默认值：application/x-www-form-urlencoded 代表的是 ajax 的 data 是以字符串的形式 如 id=2019&password=123456
  - 使用这种传数据的格式，无法传输复杂的数据，比如多维数组、文件等
    有时候要注意，自己所传输的数据格式和ajax的contentType格式是否一致，如果不一致就要想办法对数据进行转换
    把contentType 改成 false 就会改掉之前默认的数据格式，在上传文件时就不会报错了。
