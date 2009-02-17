# Amnesia

Amnesia is what you get when you lose your memory. 

Hopefully with Amnesia you'll know exactly whats happening with memory when it comes to memcached.

![Amnesia screen shot](http://img.skitch.com/20090217-cfrqkent9df5fkgujkdy9r1r8w.jpg "Amnesia")

## Why?

Its always nice to have some statistics to see how everything is performing within your stack. Memcached seems to be a  mystery box that people don't really pay alot of attention to.

Amnesia tells you how your application is performing, when it misses, when it is running sweet, when you're about to run out of memcached and (perhaps) fall down in a screaming heap.

## What does it tell you? 

All stats are since each memcached instance was restarted

Available as a cumluative result of all your memcached instances, or single instances alone:

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

Install a plethora of dependencies, I really wanted to make amnesia a gem, but being that its an application, it would mean more meaningless coding for me than I really want to do.

    sudo gem install sinatra dm-core do_sqlite3 memcache-client activesupport gchart rspec

I recommend that you stick to using sqlite3 in production, the persistance side of Amnesia is _very_ light.

Use capistrano, vlad or dump it straight onto your server, you'll need to rename amnesia.yml.example to amnesia.yml and make some changes. 

### Authentication

If you don't want authentication, remove the auth block from amnesia.yml

Be sure to set your `RackEnv` environment variable and run `rake db:migrate`, this will create your database (when using sqlite3, Mysql users will need to create the db themselves prior)

### Servers

If you plan to run Amnesia on a VPS, I recommend that you use Passenger, this is just so that you can claim back your memory when Amnesia isn't in use. Having said that, it'll work with any Rack based Ruby web server. 

You can install Apache, Passenger and Ruby Enterprise (with other friends if you like) quickly using [passenger-stack](http://benschwarz.github.com/passenger-stack)

The config.ru file provided should be fine to use in production.

When passenger isn't an option, or you want to keep things simple, you can always run your app with the `rackup` command:

      # Start on port 80 using mongrel
      rackup config.ru -p 80 -s mongrel

## Potential issues

* Hosts are listed as "Inactive" or "Not Responding"

Amnesia uses memcached-client to connect to memcached on the standard memcached port (11211), be sure to enter your
full hostname with the port if you are using a non standard port. (localhost:11211 will work)

Within my slices, I punched a hole through `iptables`

    sudo iptables -A INPUT -i eth0 -s HOST_THAT_REQUIRES_ACCESS -p tcp --destination-port 11211 -j ACCEPT

You won't need to do this unless you've explicitly blocked ports to your server. (When in doubt, block nearly everything)

Let me know if you come accross any issues using Github messaging.

## Licence

MIT, See `LICENCE` file.

## Thanks

To the [Integrity](http://github.com/foca/integrity) project for having a Sinatra app open source with some clever ideas, I pinched some of them.
This was my first real play with Sinatra and I throughly enjoyed it. (and I got to build an app that I actually needed)