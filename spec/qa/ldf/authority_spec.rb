require 'spec_helper'

describe Qa::LDF::Authority do
  it_behaves_like 'an ldf authority'

  subject(:authority) do
    auth = described_class.new

    auth.client = FakeClient.new do |client|
      client.graph = RDF::Graph.new << statement
      client.label = ldf_label
    end

    auth
  end

  let(:ldf_label)    { 'Marble Island (Nunavut)' }
  let(:ldf_uri)      { 'http://id.loc.gov/authorities/subjects/sh2004002557' }

  let(:statement) do
    [RDF::URI(ldf_uri), RDF::Vocab::SKOS.prefLabel, RDF::Literal(ldf_label)]
  end

  describe '#dataset' do
    it 'defaults an empty string symbol' do
      expect(described_class.new.dataset).to eq :''
    end
  end
end
