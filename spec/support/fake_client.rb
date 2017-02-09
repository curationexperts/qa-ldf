require 'support/shared_examples/ld_cache_client'

require 'rdf'
require 'rdf/vocab/skos'

##
# A fake version of `Qa::LDF::Client`.
class FakeClient
  attr_accessor :label, :graph

  def initialize
    yield self if block_given?
  end

  def get(uri:)
    graph ||= RDF::Graph.new
    graph =
      graph.dup <<
      [RDF::URI(uri), RDF::Vocab::SKOS.prefLabel, label || 'moomin']
    graph
  end
end

describe FakeClient do
  subject(:client) { described_class.new }

  let(:uri) { 'http://id.loc.gov/authorities/subjects/sh2004002557' }
  it_behaves_like 'an ld cache client'
end
