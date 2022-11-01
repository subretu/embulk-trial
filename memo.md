# 作業メモ
## embulk
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

## digdag
- embulkを実行させるときのymlはどこにおくべきか？
  - config.ymlの絶対パスを書くことで実行可能。
- スケジュールで実行
  ```sh
  digdag scheduler
  ```