# Overview
- It is based on ngrok.
- Unlike ngrok where logs are ephemeral, it can persist logs in local file system.

# Prerequisite
- Ngrok account
- docker for mac
- jq (optional)

> For mac, need to make sure nfs is ready to use.

# How to setup
Copy `.env.example` to `.env`, and replace `your_auth_key` with authentication key of your Ngrok account.

## How to run

Run the command below.

```shell
./run.sh
```

And you will get the results as below:
```
// If you have jq installed, you can get the callback URL directly.

$ ./run.sh 
Creating network "dynamic-callback-url_callbacknet" with the default driver
Creating dynamic-callback-url_ngrok_1 ... done
Creating dynamic-callback-url_app_1   ... done
Do you have jq installed? [y/n]: y

Callback URL:
https://caf68ba7f2ed.ngrok.io/callback/


// Else you need to vist http://localhost:4040 to get the callback URL.
// And you have to manually add /callback/ at the end of the callback URL.

$ ./run.sh 
Creating network "dynamic-callback-url_callbacknet" with the default driver
Creating dynamic-callback-url_ngrok_1 ... done
Creating dynamic-callback-url_app_1   ... done
Do you have jq installed? [y/n]: n

You can visit http://localhost:4040 to get your callback url...
```

# How to test

> ## Example 1 (POST Method)

```shell
curl -X POST -H "Content-Type: application/json" -d '{"count":5}' \
https://caf68ba7f2ed.ngrok.io/callback/test1
```

Callback is recorded in `log/callback_test1.log`.

```log
2020/08/17 03:43:40 {"count":5}
```

> ## Example 2 (POST Method)

```shell
curl -X POST -H "Content-Type: application/json" -d '{"count":5}' \
https://caf68ba7f2ed.ngrok.io/callback/test1/innerTest
```

Callback is recorded in `log/callback_test1_innerTest.log`.

```log
2020/08/17 03:45:00 {"count":5}
```

> ## Example 3 (GET Method)

```shell
curl https://caf68ba7f2ed.ngrok.io/callback/test1/innerTest?param1=123&param2=abc
```

Callback is recorded in `log/callback_test1_innerTest.log`.

```log
2021/04/13 07:11:45 param1=123&param2=abc
```

# How to close

After you done the callback testing, you can shut it down by running the command as below.
```shell
./down.sh
```

# Docker Images Used
- [Go](https://hub.docker.com/_/golang)
- [ngrok](https://hub.docker.com/r/ngrok/ngrok)
