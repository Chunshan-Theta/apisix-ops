openssl genrsa -out server.key 2048 && \
openssl req -new -sha256 -key server.key -out server.csr -subj "/CN=apisix.lazyinwork.com" && \
openssl x509 -req -days 36500 -sha256 -extensions v3_req \
-CA ca.crt -CAkey ca.key -CAserial ca.srl -CAcreateserial \
-in server.csr -out server.crt

export server_cert=$(cat server.crt)
export server_key=$(cat server.key)


curl -i "http://127.0.0.1:9180/apisix/admin/ssls" -X PUT \
-H "X-API-KEY: //add a key here" \
-d '
{
  "id": "quickstart-tls-client-ssl",
  "sni": "apisix.lazyinwork.com",
  "cert": "'"${server_cert}"'",
  "key": "'"${server_key}"'"
}'

