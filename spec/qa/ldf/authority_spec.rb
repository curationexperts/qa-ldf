require 'spec_helper'

describe Qa::LDF::Authority do
  subject(:authority) do
    auth = described_class.new

    auth.client = FakeClient.new do |client|
      client.graph = RDF::Graph.new << statement
      client.label = label
    end

    auth
  end

  let(:label)        { 'Marble Island (Nunavut)' }
  let(:endpoint_uri) { RDF::URI.intern(server_endpoint) }
  let(:subject_uri)  { 'http://id.loc.gov/authorities/subjects/sh2004002557' }

  let(:statement) do
    [RDF::URI(subject_uri), RDF::Vocab::SKOS.prefLabel, RDF::Literal(label)]
  end

  describe '#all' do
    it 'is enumerable' do
      expect(authority.all).to respond_to :each
    end

    it 'enumerates the vocabulary'
  end

  describe '#find' do
    it 'returns a JSON-like hash' do
      expect(authority.find(subject_uri)).to be_a Hash
    end

    it 'includes an id' do
      expect(authority.find(subject_uri)[:id]).to eq subject_uri
    end

    it 'includes a label' do
      expect(authority.find(subject_uri)[:label]).to eq label
    end
  end

  describe '#search' do
    it 'searches the vocabulary'
  end
end
