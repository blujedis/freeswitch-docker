# FreeSWITCH Docker

Simple Dockerfile and build tools for creating a FreeSWITCH instance in Docker container.

## Variables

Environment variables prefixed with FS_ will be passed to freeswitch.

Default variables below:

*  FS_EVENT_PASSWORD - the event socket password (random if not set)
*  FS_EVENT_PORT - the event socket port (8020 if not set)
*  FS_DEFAULT_PASSWORD - default password in freeswitch (random if not set)
*  FS_XMLRPC_USER - the user for basic auth when doing http xmlrpc requests (random if not set)
*  FS_XMLRPC_PASSWORD - the password for basic auth when doing http xmlrpc requests
*  FS_XMLRPC_PORT - the port to use when doing http xmlrpc requests(8080 by default)
*  FS_WS_PORT - the port to use for plain text websocket-sip connections(7480 by default)
*  FS_WSS_PORT - the port to use for SSL/TLS websocket-sip connections(7443 by default)
*  FS_SIP_PORT - the port to use for plain text tcp/udp sip connections(5060 by default)
*  FS_TLS_PORT - the port to use for TLS sip connections(5061 by default)

## Building:

```
docker build -t freeswitch .
```

## Running Image:

```
docker run --rm -it -p 7480:7480 freeswitch:latest
```

## Example:

```
docker run --rm -it -p 5480:5480 -e "FS_WS_PORT=5480" -e "FS_XMLRPC_PASSWORD=TEST" blujedi/freeswitch-docker:latest
```
