1.安装依赖
#yum install -y cmake gcc-c++* make ncurses-devel
2.创建mysql用户
#groupadd mysql
#useradd -r -g mysql -s /bin/false mysql
3、 ./bin/mysqld --user=mysql --basedir=/data/mysql --datadir=/data/mysqldata --initialize 
4、拷贝配置文件模板为新的mysql配置文件
	#cp my-default.cnf /etc/my.cnf
5、配置mysql服务开机自动启动
# cp /home/mysql/support-files/mysql.server /etc/init.d/mysqld      # 拷贝启动文件到/etc/init.d/下并重命令为mysqld
# chmod 755 /etc/init.d/mysqld                                      # 增加执行权限
# chkconfig --list mysqld                                           # 检查自启动项列表中没有mysqld这个，
# chkconfig --add mysqld                                            # 如果没有就添加mysqld：
# chkconfig mysqld on                                               # 用这个命令设置开机启动：
6、ln -s /data/mysql/bin/mysqld /usr/local/mysql/bin/mysqld
7、添加域名解析
	a、vi /etc/resolv.conf 
	b、nameserver 114.114.114.114

iptables -I INPUT 3 -p tcp -s 58.220.195.219 --dport 3306 -j ACCEPT

                                                                                                                                                                                                                                              