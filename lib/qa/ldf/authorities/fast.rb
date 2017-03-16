# frozen_string_literal: true
module Qa
  module LDF
    ##
    # A caching OCLC Faceted Application of Subject Terminology (FAST)
    # authority.
    #
    # @see LinkedDataFragments::CacheServer
    # @see http://www.oclc.org/research/themes/data-science/fast.html
    class FAST < Authority
      DEFAULT_DATASET_NAME = :fast
      NAMESPACE            = 'http://id.id.worldcat.org/fast/'.freeze

      register_namespace(namespace: NAMESPACE,
                         klass:     self)

      ##
      # @return [String] the URI namespace associated with this authority
      def self.namespace
        NAMESPACE
      end

      ##
      # Uses the LC AssignFast 'all' subauthority as the search provider
      def search_service
        @search_service ||= Qa::Authorities::AssignFast.subauthority_for('all')
      end
    end
  end

  ##
  # Alias to hack Qa's namespaced authority logic.
  #
  # @see https://github.com/projecthydra-labs/questioning_authority/issues/137
  module Authorities
    Fast = LDF::FAST
  end
end
