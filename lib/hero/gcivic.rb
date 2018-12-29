require 'faraday'
require 'faraday_middleware'
require 'uri'
require 'json'
require 'pp'
require 'csv'
require 'rails'
require "action_controller/railtie"
require 'active_model'

module Hero
  module Gcivic

    if defined?(Rails)
      puts 'engine'
      require 'hero/gcivic/engine'
    else
      puts 'ruby'
      require 'hero/gcivic/base'
    end
  end
end
