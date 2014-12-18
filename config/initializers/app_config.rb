# Load application configuration
require 'ostruct'
require 'yaml'

Rails.application.secrets.stringify_keys.each {|k,v| ENV[k] = v.to_s}
