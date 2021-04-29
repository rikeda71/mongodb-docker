# mongo-docker

docker-compose による mongodb の環境設定

## Requirements

- docker

## Usage

1. （バックアップがある場合）データを解凍

1. `MONGODUMP` というフォルダが出てくるので、それをこのプロジェクトのルートに配置
    - 以下のようになればOK

    ```tree
    .
    ├── MONGODUMP
    │   ├── README.md
    │   └── articles
    ├── Makefile
    ├── README.md
    ├── data
    │   ├── db
    │   └── tmp
    ├── docker-compose.yml
    └── export_csv.sh
    ```

1. `make up` を実行

あとは `make help` で使い方を確認しながらできる。。？
