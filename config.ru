require './application.rb'

set :run, false

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Sinatra::Application
