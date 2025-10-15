Prerequisites:
- **[docker](https://www.docker.com)**, using [compose.yaml](compose.yaml) which runs [tansu](https://tansu.io) and [MinIO](https://min.io)
- **[just](https://github.com/casey/just)**, a handy way to save and run project-specific commands
- **[uv](https://github.com/astral-sh/uv)**, an extremely fast Python package and project manager used to run the [pyiceberg](https://py.iceberg.apache.org) examples

[justfile](./justfile) contains recipes to run [MinIO](https://min.io), create the S3 bucket, and run [Tansu](https://tansu.io).

Once you have the prerequisites installed, clone this repository and start everything up with:

```shell
git clone git@github.com:tansu-io/example-aiokafka.git
cd example-aiokafka
just up
```

## Topic Creation

In this example we will create a `customer` topic with 3 partitions:

```shell
just customer-topic-create
```

## Consumer

As the topic has three partitions, up to three consumers can be allocated to them. To begin, start with a single consumer, send some messages and observe the partition shown on the message (the first numeric field after the topic name). Then add another consumer and subsequently kill one or more to observe the group rebalancing.

```
just consumer
```

## Producer

Produce a single message to the `customer` topic:

```
just producer
```
