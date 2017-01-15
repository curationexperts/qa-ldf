# frozen_string_literal: true
require "bundler/setup"
Bundler.setup

require 'pry' unless ENV["CI"]

require 'qa/ldf'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.tty = true

  config.formatter = :progress
end
