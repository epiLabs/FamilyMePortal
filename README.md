## Launch test suite

```shell
rake cucumber:ok
```

## Use git flow

Read [this](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/ "Why aren't you using git flow?")

## Workflow

```shell
$ git flow feature start my_feature
[Develop your feature...]
$ rake cucumber:ok
```

ONLY if all tests are OK, do the following:

* Push your feature on github: `git push origin feature/my_feature`
* Deliver the ticket on our [pivotal tracker](https://www.pivotaltracker.com/projects/681787 'FamilyMe Portal')
* Open a pull request (To the __develop branch__ PLEASE)
* Your feature should contain tests associated with it, if not the pull request will be refused (except if it's just some style change)

## Ressources

* Cucumber: Read [this](http://cukes.info/ "Official website") and [this](https://github.com/cucumber/cucumber "Github repo")
* Devise: [Github repository](https://github.com/plataformatec/devise "Github")

# TODO

Improve this readme

### Authenticate through API

```shell
curl -X POST \
   -H "Accept: application/json" \
   -d 'user[email]=dimitri@yopmail.fr&user[password]=toto42' \
    http://localhost:3000/users/sign_in
=> {"response":"ok","nickname":null,"first_name":null,"last_name":null,"auth_token":"sYcyvuHUopjT46iMhkU5"}
```
