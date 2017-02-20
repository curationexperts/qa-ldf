shared_examples 'an ld cache client' do
  before do
    raise 'Must define `uri` via `let(:uri)` to use examples' unless
      defined?(uri)
    raise 'Must define `client` via `let(:client)` to use examples' unless
      defined?(client)
  end

  define :be_a_graph_with_subject do |expected|
    match do |actual|
      expect(actual).to respond_to :each_statement
      expect(actual).to respond_to :query
      expect(actual).to have_subject RDF::URI(expected)
    end
  end

  describe '#get' do
    it 'gives a graph with the subject' do
      expect(client.get(uri: uri)).to be_a_graph_with_subject RDF::URI(uri)
    end

    it 'adds to the root dataset'

    context 'when passing a named dataset' do
      let(:dataset) { 'viaf' }

      it 'gives a graph with the subject' do
        expect(client.get(uri: uri, dataset: dataset))
          .to be_a_graph_with_subject RDF::URI(uri)
      end

      it 'adds to the named dataset'
    end
  end
end
