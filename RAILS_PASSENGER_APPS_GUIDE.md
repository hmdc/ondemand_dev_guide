# Rails Passenger Apps Guide

This guide is to help create Open OnDemand Passenger apps in Ruby on Rails. 
With these steps, you will be able to create an application from scratch 
and deploy it in your local environment.

There is a [Rails Sample app](sample_apps/rails_sample) in this repository that you can use as 
a starting point to create your own app.

### Determine the Ruby version available in the On Demand Cluster

- The first step is to determine what is the OnDemand version running in your cluster. You can see that by browsing 
to the home page and looking at the footer:

![Local Image](images/rails_passenger_apps_guide/01_ood_homepage_with_version.png)

Assuming that Cannon cluster is running OnDemand version 3.1.7, we can see the Ruby version on the release notes:
[https://osc.github.io/ood-documentation/latest/release-notes/v3.1-release-notes.html#dependency-updates](https://osc.github.io/ood-documentation/latest/release-notes/v3.1-release-notes.html#dependency-updates). 

Here we can read that the Ruby version is **3.1**

### Determine the latest supported Rails version

According to the Rails Guides Ruby versions section [https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#ruby-versions](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#ruby-versions), 
the latest Rails version supported by Ruby 3.1 is **Rails 7.2**

### Develop the Rails application for OnDemand

## Install Rbenv

It is recommended to install the same Ruby version in the local environment, in order to develop de Rails application. 
To manage many Rails versions, you can use `rbenv` in the system. To install it, follow the instructions described in 
the documentation [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv). It is also recommended to install 
the Ruby Build plugin [https://github.com/rbenv/ruby-build#readme](https://github.com/rbenv/ruby-build#readme). Once 
you have installed `rbenv`, you can install the Ruby version you want.

NOTE: There are other Ruby version managers such as `rvm` or `asdf`. You can use the Ruby version manager you prefer. 
In this guide we are going to describe the steps with `rbenv`.

## Install Ruby

To see the available Ruby minor versions with 3.1 as the mayor version, you can run this command:

```bash
rbenv install -l | grep 3.1
```

The command says that the latest installable minor version for 3.1 is `3.1.5`. Alternatively, you can check the 
released Ruby versions here [https://www.ruby-lang.org/en/downloads/releases/](https://www.ruby-lang.org/en/downloads/releases/).

Let's install the that Ruby version:

```bash
rbenv install 3.1.5
```
NOTE: you may need to install some development libraries in order to compile Ruby in your system.

Once you have Ruby installed, you can set this version as the local or global Ruby in your system, to do the following steps.

```bash
rbenv local 3.1.5
```
or
```bash
rbenv global 3.1.5
```

## Install Ruby on Rails

You can see the available Rails versions here [https://rubygems.org/gems/rails/versions](https://rubygems.org/gems/rails/versions). 
Since the latest version we can use is 7.2, we'll get the latest minor version available in this moment. For this example, 
we are going to install Rails `7.2.2.1` .

```bash
gem install rails -v 7.2.2.1
```

### Generate Rails project

We can create a Rails project from scratch or reuse a template repository. To create the application from scratch, we can run this command:

```bash
rails _7.2.2.1_ new project_name
```
This command forces the usage of the Rails version we want, in case we had many Rails versions installed under the same Ruby version.

## Home controller

We need to manage the GET requests on the / route. to do this, we can generate a simple controller with one action:

```bash
cd project_name
```
```bash
rails g controller Home index
```

Then, we need to go to `config/routes.rb` file and uncomment and edit the last line with the `root` path to point to the controller and action we have just created:

```ruby
Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
```

## Precompile assets

The application will be run under OnDemand as production mode, so, we need to generate the assets to make the application work in that environment. Do this every time you update the assets:

```bash
rake assets:precompile
```
