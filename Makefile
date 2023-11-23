postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root k_bank

dropdb:
	docker exec -it postgres16 dropdb k_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/k_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/k_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

export_sqlc_auth:
	export SQLC_AUTH_TOKEN=sqlc_01HFYNJJWXZAT78VC3NHP01AXP

.PHONY: postgres createdb dropdb migrateup migratedown sqlc export_sqlc_auth