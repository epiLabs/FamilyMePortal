### Launch test

```shell
rake cubumer:ok
```

### Authenticate through API

```shell
curl -X POST \
   -H "Accept: application/json" \
   -d 'user[email]=dimitri@yopmail.fr&user[password]=toto42' \
    http://localhost:3001/users/sign_in
=> {"response":"ok","nickname":null,"first_name":null,"last_name":null,"auth_token":"sYcyvuHUopjT46iMhkU5"}
```
