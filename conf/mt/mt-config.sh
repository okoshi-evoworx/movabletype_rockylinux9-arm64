#!/bin/sh

# mt-config.cgi 生成
cat > /var/www/cgi-bin/mt/mt-config.cgi << EOF
## Movable Type Configuration File
##
## This file defines system-wide
## settings for Movable Type. In
## total, there are over a hundred
## options, but only those
## critical for everyone are listed
## below.
##
## Information on all others can be
## found at:
##  https://www.movabletype.jp/documentation/config


#======== REQUIRED SETTINGS ==========
CGIPath        /cgi-bin/mt/
StaticWebPath  /mt-static/
StaticFilePath /var/www/cgi-bin/mt/mt-static

#======== DATABASE SETTINGS ==========
ObjectDriver DBD::mysql
Database ${DB_NAME}
DBUser root
DBPassword root
DBHost db

# DBMaxRetries 5
# DBBlobMaxLen 1048576
# ObjectCacheLimit 2000

#======== MAIL =======================
MailTransfer smtp
SMTPServer smtp
SMTPPort 1025
MailEncoding UTF-8

#======== LANGUAGE =======================
DefaultLanguage ja

#======== IMAGEDRIVER =======================
# ImageDriver ImageMagick
ImageDriver GraphicsMagick
# ImageDriver Imager
# ImageDriver GD
AutoChangeImageQuality 0

#======== PSGI =======================
PIDFilePath /var/run/mt.pid

#======== THEME =======================
ThemesDirectory /var/www/themes
ThemesDirectory themes
ThemeStaticFileExtensions jpg jpeg gif png webp svg js json css ico html otf ttf woff woff2

#======== PLUGIN =======================
PluginPath plugins
PluginPath /var/www/plugins

#======== SEARCH TEMPLATES =======================
SearchTemplatePath search_templates
SearchTemplatePath /var/www/search_templates

#======== SUPPORT =======================
SupportDirectoryPath /var/www/mt-static/support
SupportDirectoryURL /mt-static/support/

#======== ALTERNATE TEMPLATE =======================
AltTemplatePath alt-tmpl
AltTemplatePath /var/www/alt-tmpl

#======== DEBUG =======================
DebugMode 0
SearchAlwaysAllowTemplateID 1

#======== FILESIZE =======================
CGIMaxUpload 512000000

#======== IMPORT =======================
ImportPath /var/www/import

EOF

# パーミッション設定 （Volumes同期後の実行なのでRUNではなくCMD内で行う）
chmod -R 777 /var/www/html && chown apache:apache /var/www/html
chmod -R 777 /data/file/error && chown apache:apache /data/file/error

# run-periodic-tasksの実行権限付与
chmod +x /var/www/cgi-bin/mt/tools/run-periodic-tasks

# 初期インストールプラグインのstaticファイルにシンボリックリンク作成
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/FormattedTextForTinyMCE /var/www/mt-static/plugins/FormattedTextForTinyMCE
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/FormattedTextForTinyMCE5 /var/www/mt-static/plugins/FormattedTextForTinyMCE5
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/FormattedTextForTinyMCE6 /var/www/mt-static/plugins/FormattedTextForTinyMCE6
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/BlockEditor /var/www/mt-static/plugins/BlockEditor
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/FacebookCommenters /var/www/mt-static/plugins/FacebookCommenters
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/OpenID /var/www/mt-static/plugins/OpenID
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/TinyMCE /var/www/mt-static/plugins/TinyMCE
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/TinyMCE5 /var/www/mt-static/plugins/TinyMCE5
ln -snf /var/www/cgi-bin/mt/mt-static/plugins/TinyMCE6 /var/www/mt-static/plugins/TinyMCE6

# PSGI起動
cd /var/www/cgi-bin/mt
crond && /usr/local/bin/starman --pid /var/run/mt.pid --port 5000 --user apache --group apache mt.psgi
