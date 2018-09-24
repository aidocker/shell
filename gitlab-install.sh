sudo yum install -y curl policycoreutils-python openssh-server postfix
# sudo systemctl enable sshd
# sudo systemctl start sshd
# sudo firewall-cmd --permanent --add-service=http
# sudo systemctl reload firewalld
# 邮件服务器
sudo systemctl enable postfix
sudo systemctl start postfix

# 清华镜像源
cat >> /etc/yum.repos.d/gitlab-ce.repo <<-EOF
[gitlab-ce]
name=Gitlab CE Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el\$releasever/
gpgcheck=0
enabled=1
EOF


sudo EXTERNAL_URL="http://47.105.82.240" yum install -y gitlab-ce
