require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'
require 'dm-sweatshop'

root = File.join(File.dirname(__FILE__), '..')

require "#{root}/amnesia.rb"
require "#{root}/spec/helpers"

Amnesia.new

include Amnesia::Spec::Helper

set :public, "#{root}/public"
set :views,  "#{root}/views"
