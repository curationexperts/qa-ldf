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
      # @param uri [String] a URI-like string
      #
      # @return [RDF::Graph]
      #
      # @see RDF::Mutable#load
      # @see RDF::LinkedDataFragments::CacheServer
      def get(uri:)
        RDF::Graph.load(uri)
      end
    end
  end
end
