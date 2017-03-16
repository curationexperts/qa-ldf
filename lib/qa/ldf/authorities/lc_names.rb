require 'qa/ldf/namespaced_search_service'

# frozen_string_literal: true
module Qa
  module LDF
    ##
    # A caching LCSH authority.
    #
    # @note This uses the search logic from the basic Loc authority that ships
    #   with QA: `Qa::Authorities::Loc::GenericAuthority`.
    #
    # @see LinkedDataFragments::CacheServer
    class LCNames < Authority
      DEFAULT_DATASET_NAME = :lcnames
      NAMESPACE            = 'http://id.loc.gov/authorities/names/'.freeze

      register_namespace(namespace: NAMESPACE,
                         klass:     self)

      ##
      # A specialized NamespacedSearchService that strips info: uris
      #
      # The basic QA LCNames authority returns the info: URIs, instead of the
      # http: URIs as IDs. This handles conversion between the two.
      # @note This is not resilient to ids other than LCNames info: uris
      class SearchService < NamespacedSearchService
        private

        def apply_namespace(id)
          super(id.split('/').last)
        end
      end

      ##
      # @return [String] the URI namespace associated with this authority
      def self.namespace
        NAMESPACE
      end

      ##
      # Uses the LC names subauthority as the search provider
      def search_service
        @search_service ||= SearchService.new do |service|
          service.namespace      = NAMESPACE
          service.parent_service =
            Qa::Authorities::Loc.subauthority_for('names')
        end
      end
    end
  end

  ##
  # Alias to hack Qa's namespaced authority logic.
  #
  # @see https://github.com/projecthydra-labs/questioning_authority/issues/137
  module Authorities
    Lcnames = LDF::LCNames
  end
end
