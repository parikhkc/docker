Spring XD Singlenode Docker Image
=================================
This image starts XD Singlenode in background and drops you in XD Shell.

Start the container in interactive mode `-i`. This start the Spring XD Singlenode server in background. It then starts Spring XD shells ready for creating steams and jobs.

```
docker run --name xd -it -P kparikh/springxd-singlenode
```

Here's how it looks

```
localhost: kparikh$ docker run --name xd -it -P kparikh/springxd-singlenode
Starting Spring XD Singlenode

............
Spring XD Single node started.

Logs are available at : /opt/springxd/xd/logs/singlenode-console.log

Starting Spring XD Shell

 _____                           __   _______
/  ___|          (-)             \ \ / /  _  \
\ `--. _ __  _ __ _ _ __   __ _   \ V /| | | |
 `--. \ '_ \| '__| | '_ \ / _` |  / ^ \| | | |
/\__/ / |_) | |  | | | | | (_| | / / \ \ |/ /
\____/| .__/|_|  |_|_| |_|\__, | \/   \/___/
      | |                  __/ |
      |_|                 |___/
eXtreme Data
1.0.0.RELEASE | Admin Server Target: http://localhost:9393
Welcome to the Spring XD shell. For assistance hit TAB or type "help".
xd:>
```

Let's create a stream

```
xd:>stream create ticktock --definition "time | log" --deploy 
Created and deployed new stream 'ticktock'
xd:>stream list
  Stream Name  Stream Definition  Status
  -----------  -----------------  --------
  ticktock     time | log         deployed

xd:>runtime containers
  Container Id                          Host          IP Address   PID  Groups  Custom Attributes
  ------------------------------------  ------------  -----------  ---  ------  -----------------
  4236bb4e-91be-4234-a646-6a692e3fa7e4  65be39e03c0c  172.17.0.67  8

xd:>runtime modules 
  Module                  Container Id                          Options                                          Deployment Properties
  ----------------------  ------------------------------------  -----------------------------------------------  ---------------------
  ticktock.sink.log.1     4236bb4e-91be-4234-a646-6a692e3fa7e4  {name=ticktock, expression=payload, level=INFO}  {count=1, sequence=1}
  ticktock.source.time.1  4236bb4e-91be-4234-a646-6a692e3fa7e4  {fixedDelay=1, format=yyyy-MM-dd HH:mm:ss}       {count=1, sequence=1}

xd:>
xd:>! tail /opt/springxd/xd/logs/singlenode-console.log
command is:tail /opt/springxd/xd/logs/singlenode-console.log
14:42:53,036  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:42:53
14:42:54,038  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:42:54
14:42:55,040  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:42:55
14:42:56,042  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:42:56
14:42:58,046  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:42:58
14:43:01,051  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:43:01
14:43:02,053  INFO task-scheduler-9 sink.ticktock - 2014-09-26 14:43:02
xd:>
```

In a seperate shell check container port `docker port xd 9393`

```
docker port xd 9393
0.0.0.0:49155
```

# XD UI

## Linux
http://localhost:49155

## Mac
run `boot2docker ip` to find out Docker host ip and replace it with localhost

# Exit
To exit from the XD shell leaving the docker conainer running: ^P^Q
To stop container: ^C
