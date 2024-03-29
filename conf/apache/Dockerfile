FROM --platform=linux/arm64/v8 rockylinux:9.2

RUN dnf update -y
RUN dnf install -y epel-release
RUN dnf install -y httpd httpd-devel php php-devel php-mbstring php-pdo php-gd

EXPOSE 80

# php-fpmソケット用ディレクトリを作成 /run/ = /var/run/
RUN mkdir /var/run/php-fpm

# php-fpmとapacheを起動
CMD php-fpm -D; httpd -D FOREGROUND