---
title: 构建自己的 lnp 镜像文件
date: 2024-06-22 00:00:00
---
# 构建自己的 lnp 镜像文件

> 本文记录使用 Dockerfile 构建自己的lnp过程，没有数据库（需要加上数据库的也可以加上，过程类似）
> 本次构建使用编译安装，原因是想要学一下
> 首先分享我本次构建用到的资源
> [my-lnmp.zip](https://www.lanzouy.com/iFAHpxpemqf)

### ``my-lnmp.zip``

> my-lnp8.zip # php8.1
>
> my-lnp7.zip # php7.4
> 两个文件仅在php版本上有差异

然后放出Dockerfile 文件,Dockerfile有两个
分别是

### ``layered.DockerFile``

```
FROM debian:11.1
ADD ./resource.tar.gz /tmp
COPY ./pre-operation.sh tmp/pre-operation.sh
RUN sh /tmp/pre-operation.sh
COPY ./install-php-rely.sh /tmp/install-php-rely.sh
RUN sh /tmp/install-php-rely.sh
COPY ./install-php.sh /tmp/install-php.sh
RUN sh /tmp/install-php.sh
COPY ./install-nginx-rely.sh /tmp/install-nginx-rely.sh
RUN sh /tmp/install-nginx-rely.sh
COPY ./install-nginx.sh /tmp/install-nginx.sh
RUN sh /tmp/install-nginx.sh
COPY ./install-composer.sh /tmp/install-composer.sh
RUN sh /tmp/install-composer.sh
COPY ./config.sh /tmp/config.sh
RUN sh /tmp/config.sh
EXPOSE 80
LABEL wanQQ="w_c_y_929@163.com"
WORKDIR /usr/share/nginx/html/public
CMD ["/home/run.sh"]
```

### ``polymeric.DockerFile``

```
FROM debian:11.1
ADD ./resource.tar.gz /tmp
RUN sh /tmp/build.sh
EXPOSE 80
LABEL wanQQ="w_c_y_929@163.com"
WORKDIR /usr/share/nginx/html/public
CMD ["/home/run.sh"]
```

- polymeric.DockerFile 和 layered.DockerFile 构建出的镜像大小类似
![20240623211043](http://img.wanstu.cn/vscode/picgo/20240623211043.png)

- 但是 polymeric.DockerFile 构建出的镜像层数比 layered.DockerFile 少，见仁见智吧
- my-lnp8.zip 和 my-lnp7.zip 中均有 resource.tar.gz 文件 内容仅有少许差异，这里只列举 my-lnp8.zip 中的resource.tar.gz 文件

> resource.tar.gz 文件中包含
>
> - layered.DockerFile    # 多层构建的 DockerFile 文件
> - polymeric.DockerFile  # 紧凑构建的 DockerFile 文件
> - run.sh        # 镜像每次启动执行的 shell 放到 /home 目录
> - build.sh      # 最终构建镜像时运行的shell命令（暂时不必理会），放到 /tmp 目录
> - sources.list  # 阿里云镜像源文件在 [此处](https://developer.aliyun.com/mirror/debian) 查看
> - php-8.1.0.tar.xz # PHP源码文件 在[此处](https://www.php.net/downloads.php)找到并下载想要安装的 PHP 版本
> - nginx-1.21.4.tar.gz # nginx源码文件在[此处](http://nginx.org/download/)找到并下载想要安装的 nginx 版本
> - default.conf # nginx 配置文件(会被 nginx.conf 引用)
> - nginx.conf   # nginx 配置文件
> - nginx # 使 nginx 开机启动的脚本文件
> - pre-operation.sh # 最先在 Dockerfile 运行的脚本
> - install-php-rely.sh `<br>`# 安装 编译 PHP 需要的依赖（这些依赖根据编译 PHP 时的扩展设置变化，需要自行判断需要那些依赖）
> - install-php.sh # 编译安装 PHP
> - install-nginx-rely.sh `<br>`# 安装 编译 Nginx 需要的依赖（这些依赖根据编译 Nginx 时的扩展设置变化，需要自行判断需要那些依赖）
> - install-nginx.sh `<br>`# 编译安装 Nginx 由于部分依赖已经在 install-php-rely.sh 安装所以在 install-nginx-rely.sh 中没有重复安装 所以本文件需要在 install-php-rely.sh 和 install-nginx-rely.sh 都执行完以后执行
> - install-composer.sh # 安装 composer
> - config.sh # 对 php 和 nginx 进行配置

- 依赖的安装随着各系统和配置的不同会有所差异，在执行 configure 时会根据参数的不同编译不同的扩展，如果有缺失依赖的扩展将会报错，根据报错安装对应的包即可，**需要注意的是**，configure 时报错提示的包名和在软件源中的**包名不一定一样**，需要根据自己的系统在搜索引擎中搜索
- 下面看每个 shell 文件的内容和作用

### ``pre-operation.sh``

```bash
#! /bin/bash
# 换源 执行部分前置操作
rm /etc/apt/sources.list #删除原来的apt源
cp /tmp/sources.list /etc/apt/sources.list #安装提前准备好的软件源
cp /tmp/run.sh /home/run.sh # 将运行文件放到 /home
cd /tmp
tar zxvf php-8.1.0.tar.gz
tar zxvf nginx-1.21.4.tar.gz
chmod +x /home/run.sh # 给 此文件执行权限
groupadd nobody
# 创建 nginx 用户 
groupadd nginx 
useradd -g nginx -s /sbin/nologin nginx
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates sysv-rc-conf vim wget unzip tmux redis php-pear #安装一些自己可能会用到的软件，自行选择

```

- 这一步主要做一些准备工作，将所有的资源解压到 /tmp 文件夹
- 更换软件源（这里是阿里的 sources.list 可以自行准备其他的国内源，不想换源也可以不换源）
- 创建 nginx 用户 如果这里不创建 nginx用户，在 nginx 编译安装时需要去除对应的配置
- 安装一些自己想用的软件 自行选择
  阿里 sources.list 内容

```
deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib

```

### ``install-php-rely.sh``

```bash
#! /bin/bash
# 安装编译 PHP 所需依赖
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get -y install build-essential autoconf automake libtool make re2c bison pkg-config libxml2-dev openssl libssl-dev libcurl4-openssl-dev libsqlite3-dev libonig-dev zlib1g-dev # 安装 PHP 依赖
#获取 redis 扩展
cd /tmp/php-8.1.0/ext/
pecl channel-update pecl.php.net
pecl download redis
redis=$(ls -l | grep redis | awk '{print $9}')
gzip -d < $redis | tar -xvf -
rm $redis
redis=$(ls -l | grep redis | awk '{print $9}')
mv $redis redis
cd /tmp/php-8.1.0/
rm configure
./buildconf --force
```

- 安装依赖

### ``install-php.sh``

```bash
#! /bin/bash
# 编译安装 PHP

# 进入 /tmp/php-8.1.0/ 目录, php 源码解压到了这里
cd /tmp/php-8.1.0/

# 设置
./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--enable-fpm \
--enable-mbstring \
--with-curl \
--with-mysqli \
--enable-bcmath \
--with-openssl \
--with-zlib \
--enable-redis

# 编译 && 安装
make && make install

#注册环境变量
ln -s /usr/local/php/bin/php /usr/local/bin/php
ln -s /usr/local/php/sbin/php-fpm /usr/local/bin/php-fpm
```

-首先进行配置，这里的扩展项我是根据 Tp 和 Laravel 的要求所选择的，有其他需求的自行选择

- 编译 && 安装 注册环境变量 没什么可说的

### ``install-nginx-rely.sh``

```bash
 #! /bin/bash
# 安装编译 Nginx 所需依赖（部分依赖已在PHP依赖中安装，不再重复安装）
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get -y install libpcre3 libpcre3-dev libgd-dev  #安装 nginx 依赖
```

- 安装依赖,此文件中的依赖并不全，原因是在安装 PHP 依赖时一部分依赖已经被安装了

### ``install-nginx.sh``

```bash
#! /bin/bash
# 编译安装 Nginx

# 进入 /tmp/nginx-1.21.4 目录, Nginx 源码解压到了这里
cd /tmp/nginx-1.21.4/

# 设置
./configure --prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-pcre \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_image_filter_module \
--with-http_slice_module \
--with-mail \
--with-threads \
--with-file-aio \
--with-stream \
--with-mail_ssl_module \
--with-stream_ssl_module

# 编译 && 安装
make && make install

#注册环境变量
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
```

-首先进行配置，这里的扩展项我是根据别人的文章里配置的，有其他需求的自行选择

- 如果前面没有创建 nginx 用户 那么 --user=nginx --group=nginx 配置项需要去掉
- 编译 && 安装 注册环境变量 没什么可说的

### ``install-composer.sh``

```bash
#! /bin/bash

# 安装composer
cd /tmp
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
mv composer.phar /usr/local/bin/composer
## 换源
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
```

- 来自 [Packagist / Composer 中国全量镜像](https://pkg.xyz/#how-to-install-composer) 和 [阿里云 Composer 全量镜像](https://developer.aliyun.com/composer?spm=a2c6h.13651102.0.0.3e221b111yh9Lu) 没什么好讲的

### ``config.sh``

```
#! /bin/bash
#配置 配置文件
##php
cp /tmp/php-8.1.0/php.ini-production /usr/local/php/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
cp /tmp/php-8.1.0/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chmod 777 /etc/init.d/php-fpm
sysv-rc-conf php-fpm on  #开机自启

##nginx
mkdir -p /usr/share/nginx/html/public
cp /tmp/index.php /usr/share/nginx/html/public/index.php
cp /tmp/default.conf /usr/local/nginx/conf/default.conf
cp /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf
cp /tmp/nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chmod 777 /etc/init.d/nginx
sysv-rc-conf nginx on #开机自启

```

- 对 php 和 nginx 进行配置，这一块我也比较迷糊
- 配置的开机自启似乎并没有作用，所以我是使用 CMD ["/home/run.sh"] 来实现的，有懂的大佬可以给我留言

### ``run.sh``

```bash
#! /bin/bash
php-fpm
nginx
redis-server

```

- 用于启动php-fpm nginx 和 redis-server 可自行修改

### ``build.sh``

```bash
#! /bin/bash

#sh /tmp/pre-operation.sh

# 换源 执行部分前置操作
rm /etc/apt/sources.list #删除原来的apt源
cp /tmp/sources.list /etc/apt/sources.list #安装提前准备好的软件源
cp /tmp/run.sh /home/run.sh # 将运行文件放到 /home
cd /tmp
tar zxvf php-8.1.0.tar.gz
tar zxvf nginx-1.21.4.tar.gz
chmod +x /home/run.sh # 给 此文件执行权限
groupadd nobody
# 创建 nginx 用户 
groupadd nginx 
useradd -g nginx -s /sbin/nologin nginx
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates sysv-rc-conf vim wget unzip tmux redis php-pear #安装一些自己可能会用到的软件，自行选择



#sh /tmp/install-php-rely.sh

# 安装编译 PHP 所需依赖
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get -y install build-essential autoconf automake libtool make re2c bison pkg-config libxml2-dev openssl libssl-dev libcurl4-openssl-dev libsqlite3-dev libonig-dev zlib1g-dev # 安装 PHP 依赖
#获取 redis 扩展
cd /tmp/php-8.1.0/ext/
pecl channel-update pecl.php.net
pecl download redis
redis=$(ls -l | grep redis | awk '{print $9}')
gzip -d < $redis | tar -xvf -
rm $redis
redis=$(ls -l | grep redis | awk '{print $9}')
mv $redis redis
cd /tmp/php-8.1.0/
rm configure
./buildconf --force

#sh /tmp/install-php.sh

# 编译安装 PHP

# 进入 /tmp/php-8.1.0/ 目录, php 源码解压到了这里
cd /tmp/php-8.1.0/

# 设置
./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--enable-fpm \
--enable-mbstring \
--with-curl \
--with-mysqli \
--enable-bcmath \
--with-openssl \
--with-zlib \
--enable-redis

# 编译 && 安装
make && make install

#注册环境变量
ln -s /usr/local/php/bin/php /usr/local/bin/php
ln -s /usr/local/php/sbin/php-fpm /usr/local/bin/php-fpm

#sh /tmp/install-nginx-rely.sh

# 安装编译 Nginx 所需依赖（部分依赖已在PHP依赖中安装，不再重复安装）
apt update && apt upgrade -y && apt-get update && apt-get upgrade -y
apt-get -y install libpcre3 libpcre3-dev libgd-dev  #安装 nginx 依赖

#sh /tmp/install-nginx.sh

# 编译安装 Nginx

# 进入 /tmp/nginx-1.21.4 目录, Nginx 源码解压到了这里
cd /tmp/nginx-1.21.4/

# 设置
./configure --prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-pcre \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_image_filter_module \
--with-http_slice_module \
--with-mail \
--with-threads \
--with-file-aio \
--with-stream \
--with-mail_ssl_module \
--with-stream_ssl_module

# 编译 && 安装
make && make install

#注册环境变量
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx


#sh /tmp/install-composer.sh

# 安装composer
cd /tmp
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
mv composer.phar /usr/local/bin/composer
## 换源
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#sh /tmp/config.sh


#配置 配置文件
##php
cp /tmp/php-8.1.0/php.ini-production /usr/local/php/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
cp /tmp/php-8.1.0/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chmod 777 /etc/init.d/php-fpm
sysv-rc-conf php-fpm on  #开机自启

##nginx
mkdir -p /usr/share/nginx/html/public
cp /tmp/index.php /usr/share/nginx/html/public/index.php
cp /tmp/default.conf /usr/local/nginx/conf/default.conf
cp /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf
cp /tmp/nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chmod 777 /etc/init.d/nginx
sysv-rc-conf nginx on #开机自启
```

- 不再重复解释，仅是把前面的文件整合到一起
- 参考文章：

> [Debian/Ubuntu下使用sysv-rc-conf将NGINX设置为自启动 - VPS推荐 (vpstry.com)](https://www.vpstry.com/archives/77.html)
>
> [编译安装php+nginx详细步骤 - ranblogs - 博客园 (cnblogs.com)](https://www.cnblogs.com/trblog/p/13269013.html)
>
> [PHP: Unix 系统下的安装 - Manual](https://www.php.net/manual/zh/install.unix.php)
>
> [PHP 常用扩展模块 - 简书 (jianshu.com)](https://www.jianshu.com/p/f08ea79925a9)
>
> [安装 |《Laravel 8 中文文档 8.x》| Laravel China 社区 (learnku.com)](https://learnku.com/docs/laravel/8.x/installation/9354#server-requirements)
>
> [安装ThinkPHP · ThinkPHP5.0完全开发手册 · 看云 (kancloud.cn)](https://www.kancloud.cn/manual/thinkphp5/118006)
>
