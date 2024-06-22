---
title: 记一次使用 ajax 传输 文件（blob 转 file）
date: 2024-06-22 00:00:00
---
let file = new window.File([blob],fileName)
let formFile = new FormData();
formFile.append("userfile", file);
let ajax = new XMLHttpRequest();
ajax.open('POST','/api/file/uploadFormFile?userfile=' + fileName,true)
ajax.send(formFile)

