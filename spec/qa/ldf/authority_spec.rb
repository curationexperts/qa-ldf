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

  shared_context 'with registered namespaces' do
    let(:ns)       { 'http://example.com/auth/' }
    let(:subclass) { Class.new(described_class) }

    before do
      subclass.register_namespace(namespace: ns, klass: subclass)
    end
    after { subclass.reset_namespaces }
  end

  let(:ldf_label)    { 'Marble Island (Nunavut)' }
  let(:ldf_uri)      { 'http://id.loc.gov/authorities/subjects/sh2004002557' }

  let(:statement) do
    [RDF::URI(ldf_uri), RDF::Vocab::SKOS.prefLabel, RDF::Literal(ldf_label)]
  end

  describe '.for' do
    let(:ns)       { 'http://example.com/auth/' }
    let(:subclass) { Class.new(described_class) }

    before { subclass.register_namespace(namespace: ns, klass: subclass) }
    after  { subclass.reset_namespaces }

    it 'returns registered classes from namespaces' do
      expect(described_class.for(namespace: ns)).to be_a subclass
    end
  end

  describe '.namespaces' do
    it 'returns empty namespaces list' do
      expect(described_class.namespaces).to be_empty
    end

    context 'when namespaces are registered' do
      include_context 'with registered namespaces'

      it 'returns populated namespaces list' do
        expect(described_class.namespaces).to contain_exactly ns
      end
    end
  end

  describe '.register_namespace' do
    let(:ns)       { 'http://example.com/auth/' }
    let(:subclass) { Class.new(described_class) }

    after { subclass.reset_namespaces }

    it 'adds to namespace registry' do
      expect { subclass.register_namespace(namespace: ns, klass: subclass) }
        .to change { described_class.for(namespace: ns) }
        .from(described_class)
        .to(subclass)
    end
  end

  describe '.reset_namespaces' do
    include_context 'with registered namespaces'

    it 'clears the namespace list' do
      expect { subclass.reset_namespaces }
        .to change { described_class.for(namespace: ns) }
        .from(subclass)
        .to(described_class)
    end
  end

  describe '#dataset' do
    it 'defaults an empty string symbol' do
      expect(described_class.new.dataset).to eq :''
    end
  end
end
