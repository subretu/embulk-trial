## 作業メモ
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