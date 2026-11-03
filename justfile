set dotenv-load

# teardown existing, start: minio, when ready create: nisshi bucket, and then: nisshi
up: docker-compose-down minio-up minio-ready-local minio-local-alias minio-nisshi-bucket nisshi-up

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
minio-nisshi-bucket: (minio-mc "mb" "local/nisshi")

[private]
minio-ready-local: (minio-mc "ready" "local")

[private]
nisshi-up: (docker-compose-up "nisshi")

[private]
nisshi-down: (docker-compose-down "nisshi")

[private]
topic-create topic: (docker-compose-exec "nisshi" "/nisshi" "topic" "create" topic)

[private]
topic-delete topic: (docker-compose-exec "nisshi" "/nisshi" "topic" "delete" topic)


customer-topic-create: (topic-create "customer")


producer:
    uv run producer.py

consumer:
    uv run consumer.py
