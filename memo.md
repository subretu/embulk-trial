# embulk
- EC2にdocker composeをインストール方法は下記を参照。
  - https://kacfg.com/aws-ec2-docker/#EC2Docker_Composedocker-compose
- embulkコンテナ→postgresqlコンテナへの通信設定。
  - pg_hba.confで許可するhostを変更。
  - postgresqlはデフォルトではlocalhostからの通信しか許可されていないため。
  - ファイルの場所は下記
    - /var/lib/postgresql/
- embulkのコマンド。

  ```embulk
  # guess
  embulk guess ./guess.yml -o ./config.yml

  # dry-run
  embulk preview config.yml

  # run
  embulk run config.yml
  ```
- 設定ファイルの拡張子を`.yml.liquid`に変更することでファイル内で環境変数を使用することが可能。

# digdag
- embulkを実行させるときのymlはどこにおくべきか？
  - config.ymlの絶対パスを書くことで実行可能。
- スケジュールで実行
  ```sh
  digdag scheduler
  ```
## server
- serverの実行（データはメモリ（消えるので注意））
  ```sh
  digdag server --bind 0.0.0.0 --port 65432 -m
  ```
- serverの実行（データの保存はDB）
  ```sh
  digdag server --config ./server.properties
  ```
- serverの停止
  - ctrl+cかpsコマンド等でプロセスを確認してkill
- projectの登録
  ```sh
  # digファイルのあるプロジェクトへ移動
  cd /app/digdag/run_abt
  digdag push {プロジェクト名}
  ```
- projectの削除
  ```sh
  # digファイルのあるプロジェクトへ移動
  cd /app/digdag/run_abt
  digdag delete {プロジェクト名}
  ```