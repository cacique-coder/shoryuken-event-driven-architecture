# Message Broker example

This is a small application which has the idea to explain how to use shoryuken to read our SQS

## Dependencies

- Ruby 2.7.0
- Mongodb. This has been chosen, because we don't need an schema

caveats: The current dockerfile does not have a volume,

## How to run application

* Create a SNS topic in your AWS account
* Create a SQS queue and define permissions on it, follow the white in [url](https://docs.aws.amazon.com/sns/latest/dg/sns-sqs-as-subscriber.html)
* create subscription between your topic and the queue.
* ```sh
    cp .env.sample .env
    # Replaces values on .env with you own keys
    docker-compose up --build
  ```

## How to visit your application

Fetch every user
```
  curl http://127.0.0.1:5000
```

Create a new user  
```
curl -X POST --data '{"name":  "Daniel 2"}' http://127.0.0.1:5000
```
