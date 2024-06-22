#!/bin/bash
present_dir=$(pwd)
# 捕获终止信号
trap "rm -f $present_dir/i.controller;exit 1" 2
# 加载动画
function loading() {
        spin=('-' '\' '|' '/')
		i=0
		touch -f $present_dir/i.controller
        while true
		do
			if [ ! -e $present_dir/i.controller ]
			then
				break
			fi
			if(($i >= 4))
			then
				i=0
			fi
			printf "%c\b" ${spin[$((i++))]}
			sleep 0.2
		done 
}

loading&
if [ -e $present_dir/install.log ]
    then
        rm -f $present_dir/install.log
fi
if [ -e $present_dir/install_full.log ]
    then
        rm -f $present_dir/install_full.log
fi
echo "编译安装 php-8.1.2 nginx-1.21.6 redis-6.2.6 MARIADB" > $present_dir/install.log
echo "编译安装 php-8.1.2 nginx-1.21.6 redis-6.2.6 MARIADB" > $present_dir/install_full.log
system_type=$(grep "^NAME" /etc/*-release | awk -F'"' '{print $2}')
system_type=${system_type,,}
if [[ "$system_type" =~ centos.* ]]
    then
		echo "系统类型 centos"
		echo "系统类型 centos" >> $present_dir/install.log
		echo "安装依赖"
	    echo $(date)" 安装依赖" >> $present_dir/install.log
		yum -y install cpp binutils \
		glibc \
		glibc-kernheaders  \
		glibc-common \
		glibc-devel \
		gcc \
		make \
		centos-release-scl \
		devtoolset-9-gcc \
		devtoolset-9-gcc-c++ \
		devtoolset-9-binutils \
		scl \
		enable \
		devtoolset-9 \
		bash \
		automake \
		autoconf \
		libtool \
		make \
		gcc-c++ \
		libxml2-devel \
		sqlite-devel \
		libcurl-devel \
		openssl-devel \
		ncurses-devel \
		cmake >> $present_dir/install_full.log
elif [[ "$system_type" =~ ubuntu.* ]]
    then
		echo "系统类型 ubuntu"
		echo "系统类型 ubuntu" >> $present_dir/install.log
		echo "安装依赖"
	    echo $(date)" 安装依赖" >> $present_dir/install.log
		apt-get -y install curl \
		build-essential  \
		pkg-config \
		libxml2-dev \
		libcurl4-openssl-dev \
		libsqlite3-dev \
		zlib1g \
		openssl \
		libssl-dev \
		libncurses5 \
		bison \
		libncurses-dev \
		cmake >> $present_dir/install_full.log
else  
		echo $(date)" 未定义的系统类型 $system_type" > $present_dir/install.log&
		return
fi
if [ ! -e /usr/local/php/bin/php ]
    then
		echo "========================================PHP========================================" >> $present_dir/install.log
		echo "下载php-8.1.2......"
		echo $(date)" 下载 php-8.1.2.tar.gz" >> $present_dir/install.log
		curl -o php-8.1.2.tar.gz https://www.php.net/distributions/php-8.1.2.tar.gz
		echo "解压php-8.1.2......"
		echo $(date)" 解压 php-8.1.2.tar.gz" >> $present_dir/install.log
		tar zxvf php-8.1.2.tar.gz > /dev/null
		echo $(date)" 删除 php-8.1.2.tar.gz" >> $present_dir/install.log
		rm -f php-8.1.2.tar.gz
		echo $(date)" 切换到 php-8.1.2 目录" >> $present_dir/install.log
		cd $present_dir/php-8.1.2
		echo "安装 php-8.1.2......"
		echo $(date)" 配置 php-8.1.2" >> $present_dir/install.log
		./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-curl >> $present_dir/install_full.log
		echo $(date)" 编译安装 php-8.1.2" >> $present_dir/install.log
		make >> $present_dir/install_full.log && make install >> $present_dir/install_full.log
		if [ ! -e /usr/local/php/bin/php ]
			then
				echo "安装 php-8.1.2 失败"
				echo $(date)" 安装 php-8.1.2 失败" >> $present_dir/install.log
				return
		fi
		echo "配置 php-8.1.2 环境..."
		echo $(date)" 配置 php-8.1.2" >> $present_dir/install.log
		cp -f php.ini-production /usr/local/php/etc/php.ini
		cp -f /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
		cp -f /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
						cat <<EOF > /etc/profile.d/php-8.1.2-env.sh
#!/bin/bash
export PATH=\$PATH:/usr/local/php/bin:/usr/local/php/sbin/
EOF
		source /etc/profile.d/php-8.1.2-env.sh
		echo "安装 php-8.1.2 完成"
		echo $(date)" 安装 php-8.1.2 完成" >> $present_dir/install.log
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
	else 
		echo "php 已安装过"
		echo $(date)" php 已安装过" >> $present_dir/install.log
fi


if [ ! -e /usr/local/nginx/sbin/nginx ]
    then
		echo "========================================NGINX========================================" >> $present_dir/install.log
		echo "安装 nginx-1.21.6 依赖......"
		echo $(date)" 安装 nginx-1.21.6 依赖" >> $present_dir/install.log
		echo $(date)" 下载 pcre-8.45.tar.gz" >> $present_dir/install.log
		curl -o pcre-8.45.tar.gz https://nchc.dl.sourceforge.net/project/pcre/pcre/8.45/pcre-8.45.tar.gz
		echo $(date)" 解压 pcre-8.45.tar.gz" >> $present_dir/install.log
		tar zxvf pcre-8.45.tar.gz >> /dev/null
		echo $(date)" 删除 pcre-8.45.tar.gz" >> $present_dir/install.log
		rm -f pcre-8.45.tar.gz
		echo $(date)" 切换到 pcre-8.45 目录" >> $present_dir/install.log
		cd $present_dir/pcre-8.45
		echo $(date)" 配置 pcre-8.45" >> $present_dir/install.log
		./configure >> $present_dir/install_full.log
		echo $(date)" 编译安装 pcre-8.45" >> $present_dir/install.log
		make >> $present_dir/install_full.log
		make install >> $present_dir/install_full.log
		echo $(date)" 安装 pcre-8.45 完成" >> $present_dir/install.log
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
		curl -o zlib-1.2.11.tar.gz http://www.zlib.net/zlib-1.2.11.tar.gz
		echo $(date)" 解压 zlib-1.2.11.tar.gz" >> $present_dir/install.log
		tar zxvf zlib-1.2.11.tar.gz >> /dev/null
		echo $(date)" 删除 zlib-1.2.11.tar.gz" >> $present_dir/install.log
		rm -f zlib-1.2.11.tar.gz
		echo $(date)" 切换到 zlib-1.2.11 目录" >> $present_dir/install.log
		cd $present_dir/zlib-1.2.11
		echo $(date)" 配置 zlib-1.2.11" >> $present_dir/install.log
		./configure >> $present_dir/install_full.log
		echo $(date)" 编译安装 zlib-1.2.11" >> $present_dir/install.log
		make >> $present_dir/install_full.log 
		make install >> $present_dir/install_full.log
		echo $(date)" 安装 zlib-1.2.11 完成" >> $present_dir/install.log
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
		echo "下载 nginx-1.21.6......"
		echo $(date)" 下载 nginx-1.21.6.tar.gz" >> $present_dir/install.log
		curl -o nginx-1.21.6.tar.gz https://nginx.org/download/nginx-1.21.6.tar.gz
		echo $(date)" 解压 nginx-1.21.6......" >> $present_dir/install.log
		echo $(date)" 解压 nginx-1.21.6.tar.gz" >> $present_dir/install.log
		tar zxvf nginx-1.21.6.tar.gz >> /dev/null
		echo $(date)" 删除 nginx-1.21.6.tar.gz" >> $present_dir/install.log
		rm -f $present_dir/nginx-1.21.6.tar.gz
		echo $(date)" 切换到 nginx-1.21.6 目录" >> $present_dir/install.log
		cd nginx-1.21.6
		echo "安装 nginx-1.21.6......"
		echo $(date)" 配置 nginx-1.21.6" >> $present_dir/install.log
		./configure --prefix=/usr/local/nginx >> $present_dir/install_full.log
		echo $(date)" 编译安装 nginx-1.21.6" >> $present_dir/install.log
		make >> $present_dir/install_full.log && make install >> $present_dir/install_full.log
		echo "配置NGINX环境"
		echo $(date)" 配置 nginx-1.21.6 环境" >> $present_dir/install.log
		if [ ! -e /usr/local/nginx/sbin/nginx ]
			then
				echo "安装 nginx-1.21.6 失败"
				echo $(date)" 安装 nginx-1.21.6 失败" >> $present_dir/install.log
				return
		fi
				cat <<EOF > /etc/profile.d/nginx-1.21.6-env.sh
#!/bin/bash
export PATH=\$PATH:/usr/local/nginx/sbin
EOF
		source /etc/profile.d/nginx-1.21.6-env.sh
		echo "安装 nginx-1.21.6 完成"
		echo $(date)" 安装NGINX完成" >> $present_dir/install.log
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
	else 
		echo "nginx 已安装过"
		echo $(date)" nginx 已安装过" >> $present_dir/install.log
fi

if [ ! -e /usr/local/redis-6.2.6/src/redis-server ]
    then
		echo "========================================REDIS========================================" >> $present_dir/install.log
		echo "下载 redis-6.2.6......"
		echo $(date)" 下载 redis-6.2.6.tar.gz" >> $present_dir/install.log
		curl -o redis-6.2.6.tar.gz http://download.redis.io/releases/redis-6.2.6.tar.gz
		tar zxvf redis-6.2.6.tar.gz >> /dev/null
		echo $(date)" 删除 redis-6.2.6.tar.gz" >> $present_dir/install.log
		rm -f redis-6.2.6.tar.gz
		echo $(date)" 切换到 redis-6.2.6 目录" >> $present_dir/install.log
		cd $present_dir/redis-6.2.6
		echo "安装 redis-6.2.6......"
		echo $(date)" 编译 redis-6.2.6" >> $present_dir/install.log
		make >> $present_dir/install_full.log
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
		echo "安装 redis-6.2.6 并 创建符号链接"
		mv $present_dir/redis-6.2.6 /usr/local/
		if [ ! -e /usr/local/redis-6.2.6/src/redis-server ]
			then
				echo "安装 redis-6.2.6 失败"
				echo $(date)" 安装 redis-6.2.6 失败" >> $present_dir/install.log
				return
		fi
		echo $(date)" 安装 redis-6.2.6 并 创建符号链接" >> $present_dir/install.log
		ln -sf /usr/local/redis-6.2.6/src/redis-server /usr/local/bin/redis-server
		echo "安装 redis-6.2.6 成功"
		echo $(date)" 安装 redis-6.2.6 成功" >> $present_dir/install.log
		cd $present_dir
	else 
		echo "redis 已安装过"
		echo $(date)" redis 已安装过" >> $present_dir/install.log
fi

if [ ! -e /usr/local/mysql/bin/mysqld ]
	then
		echo "========================================MARIADB========================================" >> $present_dir/install.log
		echo "下载 mariadb-10.6.5.tar.gz......"
		echo $(date)" 下载 mariadb-10.6.5.tar.gz" >> $present_dir/install.log
		curl -o mariadb-10.6.5.tar.gz https://mirror.creoline.net/mariadb//mariadb-10.6.5/source/mariadb-10.6.5.tar.gz
		echo $(date)" 解压 mariadb-10.6.5......"
		echo $(date)" 解压 mariadb-10.6.5.tar.gz" >> $present_dir/install.log
		tar zxvf mariadb-10.6.5.tar.gz >> /dev/null
		echo $(date)" 删除 mariadb-10.6.5.tar.gz" >> $present_dir/install.log
		rm -f mariadb-10.6.5.tar.gz
		echo "切换到 mariadb-10.6.5/mariadb-build 目录"
		echo $(date)" 切换到 mariadb-10.6.5/mariadb-build 目录" >> $present_dir/install.log
		mkdir $present_dir/mariadb-10.6.5/mariadb-build
		cd $present_dir/mariadb-10.6.5/mariadb-build
		echo "安装 mariadb-10.6.5......"
		echo $(date)" 配置 mariadb-10.6.5" >> $present_dir/install.log
		cmake ..  >> $present_dir/install.log
		#cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
		#-DMYSQL_DATADIR=/data/mysql \
		#-DWITH_INNOBASE_STORAGE_ENGINE=1 \
		#-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
		#-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
		#-DWITH_READLINE=1 \
		#-DWITH_SSL=system \
		#-DWITH_ZLIB=system \
		#-DWITH_LIBWRAP=0 \
		#-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
		#-DDEFAULT_CHARSET=utf8 \
		#-DDEFAULT_COLLATION=utf8_general_ci >> $present_dir/install_full.log
		echo $(date)" 编译安装 mariadb-10.6.5" >> $present_dir/install.log
		make >> $present_dir/install_full.log 
		make install >> $present_dir/install_full.log
		echo $(date)" 初始化数据库" >> $present_dir/install.log
		/usr/local/mysql/scripts/mysql_install_db --datadir=/data/mysql/ >> $present_dir/install_full.log 
		echo "配置 mariadb-10.6.5 ......"
		echo $(date)" 配置 mariadb-10.6.5 环境......" >> $present_dir/install.log
		cat <<EOF > /etc/my.cnf
[mysqld]
port            = 3306
socket          = /tmp/mysql.sock
skip-external-locking
key_buffer_size = 256M
max_allowed_packet = 1M
table_open_cache = 256
sort_buffer_size = 1M
read_buffer_size = 1M
read_rnd_buffer_size = 4M
myisam_sort_buffer_size = 64M
thread_cache_size = 8
query_cache_size= 16M
thread_concurrency = 4
datadir=/data/mysql
EOF
		echo $(date)" 返回脚本目录" >> $present_dir/install.log
		cd $present_dir
		if [ ! -e /usr/local/mysql/bin/mysqld ]
			then
				echo "安装 mariadb-10.6.5 失败"
				echo $(date)" 安装 mariadb-10.6.5 失败" >> $present_dir/install.log
				rm -rf $present_dir/mariadb-10.6.5
				return
		fi
		cat <<EOF > /etc/profile.d/mariadb-10.6.5-env.sh
#!/bin/bash
export PATH=\$PATH:/usr/local/mysql/bin
EOF
		source /etc/profile.d/mariadb-10.6.5-env.sh
		echo "安装 mariadb-10.6.5 成功"
		echo $(date)" 安装 mariadb-10.6.5 成功" >> $present_dir/install.log
		echo "添加 mysql 用户"
		echo $(date)" 添加 mysql 用户" >> $present_dir/install.log
		groupadd mysql
		useradd mysql -g mysql
	else 
		echo "mariadb或mysql 已安装过"
		echo $(date)" mariadb或mysql 已安装过" >> $present_dir/install.log
fi
rm -f $present_dir/i.controller > /dev/null
wait