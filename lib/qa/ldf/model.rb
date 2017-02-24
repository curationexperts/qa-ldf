require 'active_triples'

module Qa
  module LDF
    ##
    # A base model for validatable authority values.
    class Model
      include ActiveTriples::RDFSource

      ##
      # @return [Qa::LDF::Authority]
      #
      # @example
      #   # Regester the namespace with the authority class.
      #   class MyAuthority < Authority
      #     register_namespace(namespace: 'http://example.com/my_authority#',
      #                        klass:     self)
      #   end
      #
      #   model = Qa::LDF::Model.new('http://example.com/my_authority#moomin')
      #
      #   model.authority # => #<MyAuthority:0xbad1dea>
      #
      def authority
        Qa::LDF::Authority.for(namespace: authority_namespace)
      end

      ##
      # @return [String] the namespace for the authority used by this model
      #   instance.
      #
      # @example
      #   # Regester the namespace with the authority class.
      #   class MyAuthority < Authority
      #     register_namespace(namespace: 'http://example.com/my_authority#',
      #                        klass:     self)
      #   end
      #
      #   model = Qa::LDF::Model.new('http://example.com/my_authority#moomin')
      #
      #   model.authority_namespace # => 'http://example.com/my_authority#'
      #
      def authority_namespace
        return Qa::LDF::Authority.namespace if node?

        Qa::LDF::Authority
          .namespaces
          .find { |ns| to_uri.start_with?(ns) }
      end

      ##
      # Fetches from the cache client.
      #
      # @see ActiveTriples::RDFSource#fetch
      # def fetch
      #   authority.find(to_uri)
      #   self
      # rescue => e
      #   if block_given?
      #     yield(self)
      #     self
      #   else
      #     raise e
      #   end
      # end

      class << self
        ##
        # Builds a model from the graph.
        #
        # @param graph [RDF::Graph]
        #
        # @return [Qa::LDF::Model] the built model
        def from_graph(uri:, graph:)
          new(uri) << graph
        end

        ##
        # Builds a model from a QA result hash.
        #
        # @example
        #   model =
        #     Qa::LDF::Model.from_qa_result(id:    'http://example.com/moomin',
        #                                   label: 'Moomin'
        #   model.to_uri    # => #<RDF::URI:0x... URI:http://example.com/moomin>
        #   model.rdf_label # => ['Moomin']
        #
        #
        # @param qa_result [Hash<Symbol, String>]
        #
        # @return [Qa::LDF::Model] the built model
        #
        # @todo Make ActiveTriples::RDFSource#default_labels public or
        #   protected.
        def from_qa_result(qa_result:)
          qa_result.dup
          model = new(qa_result.delete(:id))
          model.set_value(model.send(:default_labels).first,
                          qa_result.delete(:label))

          model
        end
      end
    end
  end
end
