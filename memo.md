## 作業メモ
- embulkコンテナ→postgresqlコンテナへの通信設定。
  - pg_hba.confで許可するhostを変更。
  - postgresqlはデフォルトではlocalhostからの通信しか許可されていないため。
  - ファイルの場所は下記
    - /var/lib/postgresql/
- embulkのコマンド。

  ```embulk
  # dry-run
  embulk preview config.yml

  # run
  embulk run config.yml

  ```