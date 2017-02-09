require 'spec_helper'

describe Qa::LDF::JsonMapper do
  subject(:mapper) { described_class.new }

  let(:uri)    { 'http://example.com/moomin' }
  let(:label)  { RDF::Literal('Moomin') }

  let(:graph) do
    RDF::Graph.new << [RDF::URI(uri), RDF::Vocab::SKOS.prefLabel, label]
  end

  describe '#map_resource' do
    it 'maps with an id' do
      expect(mapper.map_resource(uri, graph)[:id]).to eq uri
    end

    it 'maps with a label' do
      expect(mapper.map_resource(uri, graph)[:label]).to eq label
    end
  end
end
