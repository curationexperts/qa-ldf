# frozen_string_literal: true
require 'qa/authorities'

module Qa
  module LDF
    ##
    # A Linked Data Fragments-based authority. Access linked data resources
    # through a caching server.
    #
    # @todo Configure dataset for individual authority lookup.
    #
    # @see LinkedDataFragments::CacheServer
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
      # @!attribute [rw] dataset
      #   @return [Symbol] A dataset name (e.g. :lcsh)
      # @!attribute [rw] mapper
      #   @return [Mapper]
      attr_writer :client, :dataset, :mapper

      ##
      # @see Qa::Authorities::Base#all
      def all
        []
      end

      ##
      # Retrieves the given resource's JSON respresentation from the cache
      # server.
      #
      # The resource is retrieved through the client given by `#client`, and
      # mapped to JSON using `#mapper`.
      #
      # @see Qa::Authorities::Base#find
      # @see Qa::LDF::Client#get
      def find(id)
        graph = client.get(uri: id, dataset: dataset)

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
      # @return [Symbol]
      def dataset
        @dataset ||= :''
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
