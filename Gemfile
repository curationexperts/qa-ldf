# frozen_string_literal: true
source 'https://rubygems.org'

gemspec

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pry' unless ENV['CI']

# develop on qa master
gem 'qa', github: 'projecthydra-labs/questioning_authority', branch: 'master'
