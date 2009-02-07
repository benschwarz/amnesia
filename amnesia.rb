require 'logger'
require 'yaml'
require 'dm-core'
require 'memcache'
require 'active_support'
require 'google_chart'

Dir["app/core_ext/*.rb"].each &method(:require)

require 'app/base'
require 'app/models'
require 'app/helpers'
require 'app/web'