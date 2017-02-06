require 'spec_helper'

# @todo: pick a good way to stub graph loading behavior; these tests depends on
#   the external service. The best choice is probably to stub and contract test
#   the cache server.
describe Qa::LDF::Authority do
  include_context 'with cache server'

  subject(:authority) { described_class.new }

  let(:subject_uri)  { 'http://id.loc.gov/authorities/subjects/sh2004002557' }
  let(:endpoint_uri) { RDF::URI.intern(server_endpoint) }

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
      expect(authority.find(subject_uri)[:label])
        .to eq 'Marble Island (Nunavut)'
    end
  end

  describe '#search' do
    it 'searches the vocabulary'
  end
end
