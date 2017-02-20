module Qa
  module LDF
    ##
    # A client for the LD cache server
    class Client
      ##
      # @yield [Client] yields self to a block if given
      def initialize
        yield self if block_given?
      end

      ##
      # @param uri     [String] a URI-like string
      # @param dataset [Symbol]
      #
      # @return [RDF::Graph]
      #
      # @see RDF::Mutable#load
      # @see RDF::LinkedDataFragments::CacheServer
      def get(uri:, dataset: :'')
        RDF::Graph.load(cache_uri(uri, dataset))
      end

      private

      ##
      # @param uri     [String] a URI-like string
      # @param dataset [Symbol]
      #
      # @return [RDF::URI]
      def cache_uri(uri, dataset)
        cache_uri = RDF::URI(Qa::LDF::Configuration.instance[:endpoint])
        cache_uri.query = "subject=#{uri}"
        cache_uri = cache_uri / 'dataset' / dataset unless dataset.empty?
        cache_uri
      end
    end
  end
end
