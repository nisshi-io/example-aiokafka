topic-create topic *args:
    target/debug/tansu topic create {{topic}} {{args}}

customer-topic-create *args: (topic-create "customer" "--partitions=1"  args)

producer:
    uv run producer.py

consumer:
    uv run consumer.py
