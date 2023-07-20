FROM --platform=linux/arm64/v8 rockylinux:9.2

RUN dnf -y update && dnf -y install epel-release
RUN dnf -y install git make gcc wget zip unzip bzip2 which procps postfix vim nano cronie \
    perl-core mysql-server mysql \
    libxml2-devel expat-devel openssl-devel gmp-devel gd-devel\
    GraphicsMagick GraphicsMagick-perl \
    mod_ssl vsftpd ftp memcached \
    perl-Crypt-SSLeay
RUN dnf -y --enablerepo=devel install mysql-devel
RUN dnf clean all && rm -rf /var/cache/dnf

# CPANMの場合
# RUN curl -L http://cpanmin.us | perl - App::cpanminus
# RUN cpanm -nf \

# CPANMの代わりにCPMを使用（高速）
RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm
RUN cpm install -g --show-build-log-on-failure \
    CGI \
    Image::Size \
    File::Spec~">= 0.8" \
    CGI::Cookie \
    LWP::UserAgent \
    parent \
    HTML::Entities~">= 3.69" \
    Scalar::Util \
    DBI~">= 1.21" \
    DBD::mysql~">= 4.050"

# 参考）MovableType 必須Perlモジュール
# https://www.movabletype.jp/documentation/mt7/start-guide/about-movable-type/system-requirements/

RUN cpm install -g  \
    Archive::Tar \
    Archive::Zip \
    Authen::SASL \
    Cache::File \
    Cache::Memcached \
    CGI::PSGI \
    CGI::Parse::PSGI \
    Digest::MD5 \
    Digest::SHA \
    Digest::SHA1 \
    File::Temp \
    GD \
    List::Util \
    MIME::Base64 \
    Mozilla::CA \
    Net::SMTP \
    Net::SSLeay \
    Imager \
    IO::Compress::Gzip \
    IO::Socket::SSL \
    IO::Uncompress::Gunzip \
    JSON::PP \
    Safe \
    SOAP::Lite~">= 0.5" \
    Storable \
    Task::Plack \
    Text::Balanced \
    Time::HiRes \
    XML::Atom \
    XML::LibXML::SAX~">= 1.7" \
    XML::Parser \
    XML::SAX \
    XML::SAX::Expat \
    XML::SAX::ExpatXS \
    XMLRPC::Transport::HTTP::Plack \
    YAML::Syck \
    && rm -rf cpanfile /root/.perl-cpm /root/.cpanm /root/.qws


# 参考） オプション機能を利用するために必要な Perl モジュール
# https://www.movabletype.jp/documentation/mt7/start-guide/about-movable-type/perl-optional-modules/
# 参考）MovableTypeクラウド  インストール済み Perl モジュール
# https://www.movabletype.jp/documentation/cloud/specifications/available-perl-modules.html


COPY crontab /var/spool/cron/apache
RUN chmod 0644 /var/spool/cron/apache

EXPOSE 5000

COPY mt-config.sh ./
RUN chmod +x ./mt-config.sh
CMD ["sh", "mt-config.sh"]