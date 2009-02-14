# Stdlib
require 'rubygems'
require 'logger'
require 'yaml'

# Readily available
require 'sinatra'
require 'dm-core'
require 'memcache' # memcache-client
require 'active_support'
require 'gchart' # googlecharts

# Core extensions
Dir["app/core_ext/*.rb"].each &method(:require)

$:.unshift "#{File.dirname(__FILE__)}/app"

# Amnesia
require 'base'
require 'models'
require 'helpers'
require 'web'