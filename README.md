# Acid Challenge App Three

This application is just REST API proxy (no frontend) from a whole (basic) system.
The complete system has a client/server architecture, interconnected by this REST API proxy.
In this API, has only one endpoint that receives a specific request and sends
it to the server app, and receive a response (status codes 200 & 401 only,
plus a message).

**IMPORTANT:**

The followings steps, with the exception of **Prerequisites** and
**Running the tests**, are just for **Acid Challenge App Three**, for the other
applications you must follow their own steps specified in their Github pages.

### Prerequisites

Follow the steps of **1 Guide Assumptions** in [Ruby on Rails - Getting Started](http://guides.rubyonrails.org/getting_started.html) to install ruby on rails environment.

### Installing

To deploy the whole system, you have to clone these three applications.

* [acid-challenge-app-one](https://github.com/jisanchezp/acid-challenge-app-one) - Client app (instructions on it's GitHub Page)
* [acid-challenge-app-two](https://github.com/jisanchezp/acid-challenge-app-two) - Server app (instructions on it's GitHub Page)
* [acid-challenge-app-three](https://github.com/jisanchezp/acid-challenge-app-three) - Proxy app (this one)

1) Clone the project's repository to your local machine:

```
$ git clone https://github.com/jisanchezp/acid-challenge-app-three
```

2) Install all gems executing the following command inside project's main folder:

```
$ bundle install --without production
```

3) Create the following environment variable:

This project has Figaro gem installed.

Run this command, and it will create **config/application.yml** and will add it to git ignore.

```
$ bundle exec figaro install
create  config/application.yml
append  .gitignore
```

After this, copy/paste the following to the recently created **config/application.yml**

```
development:
  server_host: 'http://localhost:3001' # Choose any port you want, but it must
                                    # be an unused port and the same one used in
                                    # the acid-challenge-app-two application
test:
  server_host: 'http://localhost:3001'

production:
  server_host: 'enter-here-you-heroku-app-two-host-refer-to-deployment'
```

4) Start Rails server with port '3002':

```
$ rails s -p 3002
```

5) Open the [app](http://localhost:3002). You won't see any views, it's just an API.

## Running the tests

To run automated tests follow the following steps:

Pre-requisites: You should have followed the "Installing" steps for all three applications first.

1) Step into the main folder and run a command console, and type:

```
$ rails t
```

this will run ALL application tests. You want to test controllers, or models alone, use:

```
$ rails test:controllers
```

```
$ rails test:models
```

After executing the chosen command, the test results will be displayed in the command console.

## Deployment

A live version of these API has already been deployed at [heroku](https://login-api-jisanchez.herokuapp.com/)

If you want to deploy in your own account, follow this steps:

1) Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) in your local machine (if you don't have it already installed)

2) In the application root folder, open a command console and type the next commands to login on Heroku and add your SSH key

```
$ heroku login
$ heroku keys:add
```

3) Create the Heroku app:

```
$ heroku create
```

3.1) Optional step, rename your Heroku App with the following command (replace **api-best-name-ever** with the desired name:

```
$ heroku rename api-best-name-ever
```

After this, update you server_host key in **config/application.yml** points to the Heroku deployed [acid-challenge-app-two](https://github.com/jisanchezp/acid-challenge-app-two)

```
production:
  server_host: 'https://server-best-name-ever.heroku' # Don't copy paste this literally, use your own!
```

And then execute the following to set all the environment variables to Heroku at once:

```
$ figaro heroku:set -e production
```


4) Finally, push the repository master branch to Heroku repository master branch:

```
$ git push heroku master
```

## Authors

* **Juan Ignacio Sánchez** - *Initial work* - [jisanchezp](https://github.com/jisanchezp)
