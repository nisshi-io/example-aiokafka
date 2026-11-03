from aiokafka import AIOKafkaConsumer
import asyncio


async def consume():
    consumer = AIOKafkaConsumer(
        "customer", bootstrap_servers="127.0.0.1:9092", group_id="my-group"
    )
    # Get cluster layout and join group `my-group`
    await consumer.start()
    try:
        # Consume messages
        async for msg in consumer:
            print(
                "consumed: ",
                msg.topic,
                msg.partition,
                msg.offset,
                msg.key,
                msg.value,
                msg.timestamp,
            )
    finally:
        # Will leave consumer group; perform autocommit if enabled.
        await consumer.stop()


asyncio.run(consume())
