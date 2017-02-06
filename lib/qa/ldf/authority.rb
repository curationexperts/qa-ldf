# frozen_string_literal: true
require 'qa/authorities'

module Qa
  module LDF
    ##
    # A Linked Data Fragments-based authority.
    class Authority < Qa::Authorities::Base
      ##
      # The default linked data fragments client
      DEFAULT_CLIENT = Qa::LDF::Client

      ##
      # The default mapper
      DEFAULT_MAPPER = Qa::LDF::JsonMapper

      ##
      # @!attribute [rw] client
      #   @return [Client]
      # @!attribute [rw] mapper
      #   @return [Mapper]
      attr_accessor :client, :mapper

      ##
      # @see Qa::Authorities::Base#all
      def all
        []
      end

      ##
      # @see Qa::Authorities::Base#find
      def find(id)
        graph = client.get(uri: id)

        mapper.map_resource(id, graph)
      end

      ##
      # Search the vocabulary
      #
      # @param _query [String] the query string
      #
      # @return [Hash<Symbol, String>] the response as a JSON friendly hash
      def search(_query)
        {}
      end

      ##
      # @return [JsonMapper]
      def mapper
        @mapper ||= DEFAULT_MAPPER.new
      end

      ##
      # @return [Qa::LDF::Client]
      def client
        @client ||= DEFAULT_CLIENT.new
      end
    end
  end
end
