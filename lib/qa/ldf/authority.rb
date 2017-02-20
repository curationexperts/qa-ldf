# frozen_string_literal: true
require 'qa/authorities'
require 'qa/ldf/empty_search_service'

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
      DEFAULT_DATASET_NAME = :''

      ##
      # The default linked data fragments client
      DEFAULT_CLIENT = Qa::LDF::Client

      ##
      # The default mapper
      DEFAULT_MAPPER = Qa::LDF::JsonMapper

      ##
      # The default search service
      DEFAULT_SEARCH_SERVICE = Qa::LDF::EmptySearchService

      ##
      # @!attribute [rw] client
      #   @return [Client]
      # @!attribute [rw] dataset
      #   @return [Symbol] A dataset name (e.g. :lcsh)
      # @!attribute [rw] mapper
      #   @return [Mapper]
      # @!attribute [rw] search_service
      #   @return [#search]
      attr_writer :client, :dataset, :mapper, :search_service

      ##
      # @yieldparam authority [Authority] self
      def initialize(*)
        super
        yield self if block_given?
      end

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
      # @return [Array<Hash<Symbol, String>>] the response as a JSON friendly
      #   hash
      def search(query)
        search_service.search(query)
      end

      ##
      # @return [Qa::LDF::Client]
      def client
        @client ||= self.class::DEFAULT_CLIENT.new
      end

      ##
      # @return [Symbol]
      def dataset
        @dataset ||= self.class::DEFAULT_DATASET_NAME
      end

      ##
      # @return [JsonMapper]
      def mapper
        @mapper ||= self.class::DEFAULT_MAPPER.new
      end

      ##
      # @return [#search]
      def search_service
        @search_service ||= self.class::DEFAULT_SEARCH_SERVICE.new
      end
    end
  end
end
