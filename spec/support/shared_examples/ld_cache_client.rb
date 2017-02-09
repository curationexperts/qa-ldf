shared_examples 'an ld cache client' do
  before do
    raise 'Must define `uri` via `let(:uri)` to use examples' unless
      defined?(uri)
    raise 'Must define `client` via `let(:client)` to use examples' unless
      defined?(client)
  end

  describe '#get' do
    it 'returns an RDF::Enumerable' do
      expect(client.get(uri: uri)).to respond_to :each_statement
    end

    it 'returns an RDF::Queryable' do
      expect(client.get(uri: uri)).to respond_to :query
    end

    it 'gives a graph with the subject' do
      expect(client.get(uri: uri)).to have_subject RDF::URI(uri)
    end
  end
end
