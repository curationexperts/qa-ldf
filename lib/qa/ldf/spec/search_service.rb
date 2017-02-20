shared_examples 'an ldf search service' do
  before do
    unless defined?(search_service)
      raise ArgumentError,
            "#{search_service} must be defined with `let(:search_service)` " \
            'before using LDF::Authority shared examples.'
    end

    unless defined?(searches)
      warn 'You did not provide any valid searches to the ldf search service ' \
           "shared examples for #{described_class}. Use `let(:searches) = " \
           '{"query" => {key: "value"} to configure searches to test'
    end
  end

  describe '#search' do
    it 'gives a json-friendly array' do
      JSON.generate(search_service.search('tove'))
      expect { JSON.generate(search_service.search('tove')) }.not_to raise_error
    end

    it 'responds to searches' do
      if defined?(searches)
        searches.each do |query, response|
          expect(search_service.search(query)).to eq response
        end
      end
    end
  end
end
