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
      LC_SUBAUTHORITY      = 'names'.freeze

      register_namespace(namespace: NAMESPACE,
                         klass:     self)

      ##
      # @return [String] the URI namespace associated with this authority
      def self.namespace
        NAMESPACE
      end

      ##
      # Uses the LC names subauthority as the search provider
      def search_service
        @search_service ||=
          Qa::Authorities::Loc.subauthority_for(LC_SUBAUTHORITY)
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
