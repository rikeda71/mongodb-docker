## バックアップデータをDBに保存
restore:
	docker-compose exec mongodb bash -c "mongorestore -v --db data --username user --password pass --authenticationDatabase admin /data/articles/"
## csv形式で出力(/tmp/export.csvに出力): `COLLECTION=collection名 make export_csv` のように実行
export_csv:
	docker-compose exec mongodb bash -c "keys=`mongo -u user -p pass data --authenticationDatabase admin --eval "rs.slaveOk();var keys = []; for(var key in db.${COLLECTION}.findOne()) { keys.push(key); }; keys;" --quiet` && mongoexport --db data --username user --password pass --authenticationDatabase admin --collection=${COLLECTION} --fields="$keys" --type=csv --out=/tmp/export.csv"
## json形式で出力(/tmp/export.jsonに出力): `COLLECTION=collection名 make export_json` のように実行
export_json:
	docker-compose exec mongodb bash -c "mongoexport --db data --username user --password pass --authenticationDatabase admin --collection=${COLLECTION} --type=json --out=/tmp/export.json"
## mongodbが立ち上がっている仮想マシンのシェルに接続
bash:
	docker-compose exec mongodb bash
## mongodbのシェルにログイン
mongoclient:
	docker-compose exec mongodb bash -c "mongo -u user -p pass"
## mongodbの起動
up:
	docker-compose up -d
## mongodbのシャットダウン（データは残る）
down:
	docker-compose down
## mongodbの完全削除（データも削除）
destroy:
	docker-compose down
	rm -rf data/db/*
## ヘルプの表示
help:
	@cat $(MAKEFILE_LIST) | python3 -u -c 'import sys; import re; from itertools import tee,chain; rx = re.compile(r"^[a-zA-Z0-9\-_]+:"); xs, ys = tee(sys.stdin); xs = chain([""], xs); [print(f"""\x1b[36m{line.split(":", 1)[0]:20s}\x1b[0m\t{prev.lstrip("# ").rstrip() if prev.startswith("##") else "" }""") for prev, line in zip(xs, ys) if rx.search(line)]'
