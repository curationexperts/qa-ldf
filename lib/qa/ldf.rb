# frozen_string_literal: true
require 'qa/ldf/configuration'
require 'qa/ldf/version'

##
# @see https://github.com/projecthydra-labs/questioning_authority Qa
module Qa
  ##
  # Providies bindings from `qa` to a linked data fragment caching service for 
  # fast query of RDF-based authorities.
  #
  # @see https://github.com/projecthydra-labs/questioning_authority Qa
  # @see https://github.com/ActiveTriples/linked-data-fragments Linked Data 
  #   Fragments Cache
  module LDF
    ##
    # @return [Configuration] the singleton configuration instance
    def self.config
      @@config ||= configure!
    end

    ##
    # @example configuring with block syntax
    #   Qa::LDF.configure
    # @see Configuration#configure
    def self.configure!(**options, &block)
      @@config = Configuration.instance.configure!(**options, &block)
    end

    ##
    # @see VERSION
    def self.version
      VERSION
    end
  end
end
