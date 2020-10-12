# Stripe Checkout as a 1-File Rails App 

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This is a Rails version of Stripe Checkout's suggested Ruby backend, using a single file.

To use it, simply fork, modify what you need to, and deploy.

## Usage

```
$ STRIPE_API_KEY=sk_test_asdasda SECRET_KEY_BASE=test puma
```

## How Does It Work? 

1. When you run `puma`, it looks for a file called `config.ru` if you don't tell it what to run.
2. `config.ru` in this project defines a Rack application, that is, `StripeCheckout`. At the end of the file, we `run StripeCheckout`, because `run <rack-application` is how Rack defines what the application is.
3. Other than that, we basically just took all the different files generated from `rails new` and put them into a single file, then took out everything you don't absolutely need to run this app. 

## How Can I Expand It?

Basically, look at `rails new` output and then add in what you need to. Generally you can add new files in here one at a time.

## Where can I learn more about mini Rails apps?

[Here](https://github.com/nateberkopec/rails_lightweight_stack) are a bunch of examples, including one that's the size of a Tweet, and [here](https://www.youtube.com/watch?v=SXV-RRsjsFc) is a conference talk about them.