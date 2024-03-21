curl -vvv 'https://bfcf9c8d4338.ngrok.io/callback/vonage?test=123&client=gcp console'
curl 'https://2f99aee3a44e.ngrok.io/callback/vonage?test=123&client=gcp console'
curl 'https://google.com?test=123&client=gcp console'

url without encode will cause 400 bad request error.
we need log all request like a real server.

refer below:
- https://stackoverflow.com/questions/34017342/log-404-on-http-fileserver
- https://presstige.io/p/Logging-HTTP-requests-in-Go-233de7fe59a747078b35b82a1b035d36
