# MovableType Docker(Rocky Linux 9 / arm64)
- [rockylinux:9.2(linux/arm64/v8)](https://hub.docker.com/layers/library/rockylinux/9.2.20230513-minimal/images/sha256-8a14a313d4a6c3963c498de541415e0c2a122241e87f6835ae6a2511f858a916?context=explore)
- [mariadb:10.3(linux/arm64/v8)](https://hub.docker.com/layers/library/mariadb/10.3/images/sha256-d162a04f42d4281b08047ca6e1a204062d348537a621d12a734b68d64ecf2919?context=explore)
- [phpmyadmin:latest(linux/arm64/v8)](https://hub.docker.com/layers/library/phpmyadmin/latest/images/sha256-8c4760de2c17a8fb5c18cfa857d9749e5907570ecd977a73265a37a54fad0bd2?context=explore)
- [dockage/mailcatcher(linux/arm64)](https://hub.docker.com/layers/dockage/mailcatcher/latest/images/sha256-dace8abb9505079eaaf8b48bc121552c2c75dc3b9a090919f7fa2fc48caf31b1?context=explore)

## ファイル構成
```
/
├─ conf/
│   ├─ apache/
│   │  ├─ Dockerfile（Webサーバー構築）
│   │  ├─ httpd.conf（apache設定）
│   │  ├─ php.ini（php設定）
│   │  └─ vhost.conf（バーチャルホスト設定）
│   ├─ mt/
│   │  ├─ crontab （公開キュー実行のためのスケジュールタスク）
│   │  ├─ Dockerfile（MTサーバー構築）
│   │  └─ mt-config.sh ※mt-config.cgi に変更がある場合はこちらを編集してください
│   └─ mysql/
│       └─ my.cnf
├─ data/
│   └─ file/
│       └─ error/ （エラーページHTML）
│           ├─ error.html
│           ├─ forbidden.html
│           └─ unauthorized.html
├─ lib/
│   └─ mysql/ （MySQLデータ保存場所）
│   └─ session/ （phpMyAdminセッションデータ）
├─ www/
│   ├─ alt-tmpl/ (管理画面テンプレート)
│   ├─ cgi-bin/
│   │   └─ mt/ (MovableType本体) ※gitで管理していません
│   ├─ html/（ルートディレクトリ）
│   ├─ import/（MovableType サイトのインポートで使用）
│   ├─ mt-static/
│   │   ├─ plugins/（MTプラグインで使用する静的ファイルを格納します）
│   │   └─ supports/（テーマのサムネイル格納等に使用します）
│   │─ plugins/（MTプラグイン格納ディレクトリ）
│   │─ search_templates/（検索用テンプレート）
│   └─ themes/
├─ .env ※gitで管理していません。.env.exampleから複製してください
├─ .env.example
├─ .gitignore
├─ docker-compose.yml
└─ README.md
```


## Docker
### 構築
`www/cgi-bin/mt` に Movable Typeの本体ファイルを配置したら下記を実行してください。

```zsh
docker compose build
```
※ `conf/` 配下の設定を変更した場合も `build` してください。

```zsh
docker compose build --no-cache
```
※ `build`が上手くいかない場合は`--no-cache`で実行してください。

### 起動
```zsh
docker compose up -d
```
- MovableType：[http://localhost:6900/](http://localhost:6900/)
- MovableType管理画面: [http://localhost:6900/cgi-bin/mt/mt.cgi](http://localhost:6900/cgi-bin/mt/mt.cgi)
- phpMyAdmin：[http://localhost:6901/](http://localhost:6901/)
- MailCatcher：[http://localhost:6902/](http://localhost:6902/)

### 終了
```zsh
docker compose down
```
※ 必ずDocker-composeを止めてからPCを終了してください。


## Git
MT起動時にファイルパーミッションが変わり、ファイルの変更していないのに差分として認識される場合があります（Diffの内容は空）。  
その場合は下記コマンドでGitでパーミッションの変更を無視する設定にしてください。

```zsh
git config core.filemode false
```
