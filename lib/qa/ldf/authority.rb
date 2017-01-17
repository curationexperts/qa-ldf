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
      def find(_id)
        {}
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
    end
  end
end
