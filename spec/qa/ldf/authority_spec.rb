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

  describe '#client' do
    it 'defaults to an instance of DEFAULT_CLIENT' do
      expect(described_class.new.client)
        .to be_a described_class::DEFAULT_CLIENT
    end

    it 'sets to other instances' do
      client = described_class::DEFAULT_CLIENT.new

      expect { authority.client = client }
        .to change { authority.client }
        .to equal client
    end
  end

  describe '#dataset' do
    it 'defaults an empty string symbol' do
      expect(described_class.new.dataset).to eq :''
    end

    it 'sets to other symbols' do
      dataset_name = :lcsh

      expect { authority.dataset = dataset_name }
        .to change { authority.dataset }
        .to eq dataset_name
    end
  end

  describe '#mapper' do
    it 'defaults to an instance of DEFAULT_MAPPER' do
      expect(described_class.new.mapper)
        .to be_a described_class::DEFAULT_MAPPER
    end

    it 'sets to other instances' do
      mapper = described_class::DEFAULT_MAPPER.new

      expect { authority.mapper = mapper }
        .to change { authority.mapper }
        .to equal mapper
    end
  end

  describe '#search' do
    it 'searches the vocabulary'
  end
end
