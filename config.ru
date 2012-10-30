require 'mail'
require 'rack'
require 'rubygems'
require 'sinatra'
require 'aws/s3'
require './app'

run Sinatra::Application
