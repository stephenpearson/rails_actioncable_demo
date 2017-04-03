# Description

This is a simple test showing how an ActiveRecord model can be linked into an ExtJS 6
model via push notifications using ActionCable in Rails 5.

# Setup

Use either rbenv or rvm to install Ruby 2.4.0.  Install Ruby Gems to install Rails 5.0.2
Download the ExtJS 6.2.0 zipfile and extract.  This must be made available as public/extjs
Intall Redis and run using default configuration.  It should be listening on port 6379

Run bundler, migrations and then start the Puma server as normal.
```
cd rails_actioncable_demo
bundle
rails db:migrate
rails s
```

To populate with random data, use the following script:
```
rails runner randomise.rb
```

Visit URL: http://\<address>:3000/items
