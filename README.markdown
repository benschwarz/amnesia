# Amnesia

Amnesia is what you get when you lose your memory. 

Hopefully with Amnesia you'll know exactly whats happening with memory when it comes to memcached.

![Amnesia screen shot](http://farm5.static.flickr.com/4125/5030135910_698fdb4514_z_d.jpg "Amnesia")

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

    gem install amnesia

### How to run it alongside your application

"config.ru":
  
    require 'amnesia'
    use Amnesia::Application, :hosts => ["localhost:11211"]
    run Sinatra::Application

## Potential issues

* Hosts are listed as "Inactive" or "Not Responding"

Amnesia uses memcached-client to connect to memcached on the standard memcached port (11211), be sure to enter your
full hostname with the port if you are using a non standard port. (localhost:11211 will work)

Within my slices, I punched a hole through `iptables`

    sudo iptables -A INPUT -i eth0 -s HOST_THAT_REQUIRES_ACCESS -p tcp --destination-port 11211 -j ACCEPT

You won't need to do this unless you've explicitly blocked ports to your server. (When in doubt, block nearly everything)

Let me know if you come accross any issues using Github messaging.

## Something missing? 

Amnesia used to be a full blown application that required a datamapper sqlite database, yml file for configuration and a bit of pain to get deployed. I decided these were all false constraints and wrapped it up as a middleware instead. Now—You can drop it alongside your rails/sinatra/rack application and see what the hell is going on with Memcached. 

## Licence

MIT, See `LICENCE` file.