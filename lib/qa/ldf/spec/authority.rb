shared_examples 'an ldf authority' do
  before do
    unless defined?(authority)
      raise ArgumentError,
            "#{authority} must be defined with `let(:authority)` before " \
            'using LDF::Authority shared examples.'
    end

    unless defined?(ldf_uri)
      raise ArgumentError,
            "#{ldf_uri} must be defined with `let(:ldf_uri)` before using " \
            'LDF::Authority shared examples.'
    end
    unless defined?(ldf_label)
      raise ArgumentError,
            "#{ldf_label} must be defined with `let(:ldf_label)` before " \
            'using LDF::Authority shared examples.'
    end
  end

  it 'is aliased to Qa::Authorities' do
    unless described_class.eql?(Qa::LDF::Authority)
      name = described_class.to_s.split('::').last.downcase.camelize
      expect("Qa::Authorities::#{name}".constantize).to eql described_class
    end
  end

  it 'is registered' do
    expect(Qa::LDF::Authority.for(namespace: described_class.namespace))
      .to be_a described_class
  end

  describe '.namespace' do
    it 'returns a namespace string' do
      unless described_class.namespace == ''
        expect(RDF::URI(described_class.namespace)).to be_valid
      end
    end
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
    it 'defaults DEFAULT_DATASET_NAME' do
      expect(described_class.new.dataset)
        .to eq described_class::DEFAULT_DATASET_NAME
    end

    it 'sets to other symbols' do
      dataset_name = :new_name

      expect { authority.dataset = dataset_name }
        .to change { authority.dataset }
        .to eq dataset_name
    end
  end

  describe '#find' do
    it 'finds a uri' do
      expect(authority.find(ldf_uri))
        .to include id: ldf_uri.to_s, label: ldf_label
    end

    it 'maps to a json-friendly hash' do
      expect { JSON.generate(authority.find(ldf_uri)) }.not_to raise_error
    end

    context 'when dataset is not assigned' do
      before { authority.dataset = nil }

      it 'finds a uri' do
        expect(authority.find(ldf_uri))
          .to include id: ldf_uri.to_s, label: ldf_label
      end
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
    let(:query)    { 'My Fake Query' }
    let(:response) { [{ my: 'response' }] }

    it 'gives an array' do
      expect(authority.search('tove')).to respond_to :to_ary
    end

    it 'gives a json-friendly array' do
      expect { JSON.generate(authority.search('tove')) }.not_to raise_error
    end

    it 'searches the search service' do
      authority.search_service = FakeSearchService.new do |service|
        service.queries[query] = response
      end

      expect(authority.search(query)).to eq response
    end
  end
end
