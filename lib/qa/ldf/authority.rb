# frozen_string_literal: true
require 'qa/authorities'

module Qa
  module LDF
    ##
    # A Linked Data Fragments-based authority.
    class Authority < Qa::Authorities::Base
      ##
      # @see Qa::Authorities::Base#all
      def all
        []
      end

      ##
      # @see Qa::Authorities::Base#find
      def find(id)
        graph = RDF::Graph.load(id)

        json_mapper.map_resource(id, graph)
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
      # @return [JSON_Mapper]
      def json_mapper
        @json_mapper ||= JsonMapper.new
      end
    end
  end
end
