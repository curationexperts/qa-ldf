require 'active_triples'

module Qa
  module LDF
    ##
    # A base model for validatable authority values.
    class Model
      include ActiveTriples::RDFSource

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
