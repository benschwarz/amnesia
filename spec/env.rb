require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'
require 'dm-sweatshop'

root = File.join(File.dirname(__FILE__), '..')

require "#{root}/amnesia.rb"
require "#{root}/spec/support/helpers"
require "#{root}/spec/support/factory"

Amnesia.new

DataMapper.auto_migrate!

include Amnesia::Spec::Helper

set :public, "#{root}/public"
set :views,  "#{root}/views"
