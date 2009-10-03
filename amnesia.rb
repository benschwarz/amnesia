# Stdlib
require 'rubygems'
require 'logger'
require 'yaml'

# Readily available
require 'sinatra/base'
require 'dm-core'
require 'memcache' # memcache-client
require 'active_support'
require 'gchart' # gchart, on github

# Core extensions
Dir["app/core_ext/*.rb"].each {|r| require r}

# Amnesia
%w(helpers base host).each {|r| require "#{File.dirname(__FILE__)}/app/#{r}"}