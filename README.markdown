# Amnesia

Amnesia is what you get when you lose your memory. 

Hopefully with Amnesia you'll know exactly whats happening with memory when it comes to memcached.

![Amnesia screen shot](http://farm5.static.flickr.com/4125/5030135910_698fdb4514_z_d.jpg "Amnesia")

## Why?

Its always nice to have some statistics to see how everything is performing within your stack. Memcached seems to be a  mystery box that people don't really pay a lot of attention to.

Amnesia tells you how your application is performing, when it misses, when it is running sweet, when you're about to run out of memcached and (perhaps) fall down in a screaming heap.

## What does it tell you? 

All stats are since each memcached instance was restarted

Available as a cumulative result of all your memcached instances, or single instances alone:

* Cache hits and misses
* Reads and writes
* Remaining memory


Available for single instances only: 

* Amount of items stored in cache
* Connections (current and total)
* Accesses (Read / Write)
* Accuracy (Hits / Misses)
* Memory (Used / Total)

## Installation / Getting started

    gem install amnesia

### How to run it alongside your Rack application

"config.ru":
  
    require 'amnesia'
    rack_app = Rack::Builder.app do
      map "/amnesia" do
        run Amnesia::Application.new
      end
      run YourSinatra::Application
    end
    run rack_app 

### How to run it alongside your Rails application

"Gemfile":

    gem 'amnesia', '>=1.0.2'


"config/routes.rb":

    mount Amnesia::Application.new => "/amnesia" 


### Then, cruise on over to `your-host.tld/amnesia`


## Configuration options

### Hosts
Amnesia will work automagically if you drop it on a Heroku powered app, likewise—for a "standard" memcache host (running on localhost:11211, the default.).

When you need to specify where your memcache hosts can be found, you can either set an environment variable: 

    ENV["MEMCACHE_SERVERS"] = ['localhost:11211']

or alternately, you can set it within your `config.ru`:

    use Amnesia::Application, hosts: ["mc1.yourapp.com:11211", "mc2.yourapp.com:11211"]

### Authentication

When you want to keep your Amnesia data private, you can set an environment variable that will enable http basic authentication: 

    ENV["AMNESIA_CREDS"] = ben:schwarz
    
in your shell, you might do it like this: 

    export AMNESIA_CREDS=ben:schwarz
    
on heroku, like this:

    heroku config:add AMNESIA_CREDS=ben:schwarz

### Content Security Policy

Amnesia uses Google Charts to display pie charts. In case you're employing
a CSP header you'll need to add the Google Chart servers as a valid image source, e.g.:

    Content-Security-Policy: img-src 'self' data: https: https://chart.apis.google.com;

Within a Rack app you can use [Rack::Protection](http://www.sinatrarb.com/protection):

```rb
use Rack::Protection::ContentSecurityPolicy, img-src: "'self' data: https: https://chart.apis.google.com"
```

## Potential issues

* Hosts are listed as "Inactive" or "Not Responding"

Amnesia uses memcached-client to connect to memcached on the standard memcached port (11211), be sure to enter your
full hostname with the port if you are using a non standard port. (localhost:11211 will work)

Within my slices, I punched a hole through `iptables`

    sudo iptables -A INPUT -i eth0 -s HOST_THAT_REQUIRES_ACCESS -p tcp --destination-port 11211 -j ACCEPT

You won't need to do this unless you've explicitly blocked ports to your server. (When in doubt, block nearly everything)

Let me know if you come across any issues using Github messaging.

## Something missing? 

Amnesia used to be a full blown application that required a datamapper sqlite database, yml file for configuration and a bit of pain to get deployed. I decided these were all false constraints and wrapped it up as a middleware instead. Now—You can drop it alongside your rails/sinatra/rack application and see what the hell is going on with Memcached. 

## Licence

MIT, See `LICENCE` file.