#!/usr/bin/bash
# zabbix-server 3.4.1
# author: idocker@qq.com

# 安装官方zabbix yum源
rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
# 安装Zabbix部署包。
yum install zabbix-server-mysql zabbix-web-mysql -y
# 安装数据库
yum install mariadb-server -y
systemctl start mariadb;systemctl enable mariadb
mysqladmin -u root password 123456
# 创建数据库zabbix
mysql -uroot -p123456 <<-EOF
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';
quit
EOF

# 导入数据库
zcat /usr/share/doc/zabbix-server-mysql-3.4.12/create.sql.gz | mysql -uzabbix -pzabbix zabbix #-D 指定数据库亦可
mysql -uzabbix -pzabbix  zabbix < zat /usr/share/doc/zabbix-server-mysql-3.4.12/create.sql.gz
# 修改配置文件
cp /etc/zabbix/zabbix_server.conf{,-bak}
sed -ri 's/^# DBPassword=/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf
sed -ri 's/^# DBHost=localhost/DBHost=localhost/' /etc/zabbix/zabbix_server.conf
sed -ri 's/# php_value date.timezone Europe/Riga/php_value date.timezone Asia/Shanghai/' /etc/httpd/conf.d/zabbix.conf
sed -ri 's+# php_value date.timezone Europe/Riga+php_value date.timezone Asia/Shanghai+' /etc/httpd/conf.d/zabbix.conf
# 重启服务
systemctl start zabbix-server httpd;systemctl enable zabbix-server httpd