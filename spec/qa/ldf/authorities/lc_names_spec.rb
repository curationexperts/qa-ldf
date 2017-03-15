require 'spec_helper'

describe Qa::LDF::LCNames do
  it_behaves_like 'an ldf authority'

  subject(:authority) do
    auth = described_class.new

    auth.client = FakeClient.new do |client|
      client.graph = RDF::Graph.new
      client.graph.insert(*statements)
      client.label = ldf_label
    end

    auth
  end

  let(:ldf_label)    { 'Marble Island (Nunavut)' }
  let(:ldf_uri)      { 'http://id.loc.gov/authorities/subjects/sh2004002557' }

  let(:statements) do
    [RDF::Statement(RDF::URI(ldf_uri),
                    RDF::Vocab::SKOS.prefLabel,
                    RDF::Literal(ldf_label))]
  end

  before do
    # mock empty responses for all queries;
    # see spec/contracts/qa_loc_as_search_service.rb for lc search service tests
    stub_request(:get, 'http://id.loc.gov/search/?format=json&' \
                       'q=cs:http://id.loc.gov/authorities/names')
      .with(headers: { 'Accept' => 'application/json' })
      .to_return(status: 200, body: '[]', headers: {})
  end

  describe '#search' do
    context 'with real search service' do
      it 'hits the upstream loc endpoint' do
        query = 'a query'
        url   = 'http://id.loc.gov/search/?format=json' \
                "&q=#{query}&q=cs:http://id.loc.gov/authorities/names"
        expect(a_request(:get, url))

        authority.search(query)
      end
    end

    context 'with fake search service' do
      let(:search_service) do
        FakeSearchService.new { |service| service.queries = searches }
      end

      let(:searches) { { 'moomin' => results } }
      let(:results)  { [{ id: 'moomin123', name: 'Moomin' }] }

      before { authority.search_service = search_service }

      it 'returns the values' do
        expect(authority.search('moomin')).to contain_exactly(*results)
      end
    end
  end

  describe '#dataset' do
    it 'defaults to :lcnames' do
      expect(described_class.new.dataset).to eq :lcnames
    end
  end
end
