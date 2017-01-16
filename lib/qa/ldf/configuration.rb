# frozen_string_literal: true
require 'singleton'

module Qa
  module LDF
    ##
    # A singleton configuration class.
    #
    # This behaves much like a hash, but guarantees that only one configuration
    # exists and accepts a block sytax for configuration.
    #
    # @example configuring with a configuration hash
    #   Qa::LDF::Configuration.instance
    #     .configure!(endpoint: 'http://example.org/ldf/')
    #
    # @example configuring with block syntax
    #   Qa::LDF::Configuration.instance.configure! do |config|
    #     config[:endpoint] = 'http://example.org/ldf/'
    #   end
    #
    # @see Qa::LDF.config
    # @see Qa::LDF.configure!
    class Configuration
      extend Forwardable
      include Singleton

      # @!method any?
      #   @return (see Hash#any?)
      # @!method each?
      #   @return (see Hash#each)
      # @!method fetch?
      #   @param  (see Hash#fetch)
      #   @return (see Hash#fetch)
      # @!method []
      #   @param  (see Hash#[])
      #   @return (see Hash#[])
      # @!method []=
      #   @param  (see Hash#[]=)
      #   @return (see Hash#[]=)
      # @!method to_h
      #   @param  (see Hash#to_h)
      #   @return (see Hash#to_h)
      # @!method to_a
      #   @param  (see Hash#to_a)
      #   @return (see Hash#to_a)
      def_delegators :@options, :any?, :each, :fetch, :[], :[]=, :to_a, :to_h

      ##
      # @private
      # @see Singleton
      def initialize
        @options = {}
      end

      ##
      # @param opts [Hash]
      #   @option endpoint [String]
      #
      # @yield yields self to block
      # @yieldparam config [Configuration] self
      def configure!(**opts)
        @options = opts
        yield self if block_given?
        self
      end
    end
  end
end
