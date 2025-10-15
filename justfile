set dotenv-load

# teardown existing, start: minio, when ready create: tansu bucket, and then: tansu
up: docker-compose-down minio-up minio-ready-local minio-local-alias minio-tansu-bucket tansu-up

[private]
docker-compose-up *args:
    docker compose up --detach --wait {{args}}

[private]
docker-compose-down *args:
    docker compose down --volumes {{args}}

[private]
docker-compose-ps:
    docker compose ps

[private]
docker-compose-logs *args:
    docker compose logs {{args}}

[private]
minio-up: (docker-compose-up "minio")

[private]
minio-down: (docker-compose-down "minio")

[private]
docker-compose-exec service command *args:
    docker compose exec {{service}} {{command}} {{args}}

[private]
minio-mc +args: (docker-compose-exec "minio" "mc" args)

[private]
minio-local-alias: (minio-mc "alias" "set" "local" "http://localhost:9000" "minioadmin" "minioadmin")

[private]
minio-tansu-bucket: (minio-mc "mb" "local/tansu")

[private]
minio-ready-local: (minio-mc "ready" "local")

[private]
tansu-up: (docker-compose-up "tansu")

[private]
tansu-down: (docker-compose-down "tansu")

[private]
topic-create topic: (docker-compose-exec "tansu" "/tansu" "topic" "create" topic)

[private]
topic-delete topic: (docker-compose-exec "tansu" "/tansu" "topic" "delete" topic)


customer-topic-create: (topic-create "customer")


producer:
    uv run producer.py

consumer:
    uv run consumer.py
