### Launch test

```shell
rake cubumer:ok
```

### Authenticate through API

```shell
curl -X POST \
   -H "Accept: application/json" \
   -d 'user[email]=toto42@yopmail.com&user[password]=toto42' \
    http://localhost:3001/users/sign_in
=> {"response":"ok","nickname":null,"first_name":null,"last_name":null,"auth_token":"CjaqxX2znWifEm5Yc4sK"}
```

### Checkout position

```shell
curl -X POST \
   -H "Accept: application/json" \
   -d 'auth_token=CjaqxX2znWifEm5Yc4sK' \
   -d 'position[latitude]=42.989283&position[longitude]=-1.35309' \
    http://localhost:3001/api/v1/positions
```
