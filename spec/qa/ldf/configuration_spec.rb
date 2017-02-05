require 'spec_helper'

describe Qa::LDF::Configuration do
  subject(:config) { described_class.instance }

  shared_context 'with configuration' do
    before { config.configure!(**options) }
    after  { config.reset! }

    let(:options) do
      { option: :moomin }
    end
  end

  describe '#[]' do
    include_context 'with configuration'

    it 'gives nil for unconfigured options' do
      expect(config[:fake]).to be_nil
    end

    it 'accesses options' do
      options.each { |k, v| expect(config[k]).to eq v }
    end
  end

  describe '#configure!' do
    it 'configures the options' do
      expect { config.configure!(key: :value) }
        .to change { config[:key] }.from(nil).to(:value)
    end

    it 'overrides the options' do
      config.configure!(key: :value)

      expect { config.configure!(key: :new_value) }
        .to change { config[:key] }.from(:value).to(:new_value)
    end

    it 'overrides options not in new config' do
      config.configure!(key: :value)

      expect { config.configure!(new_key: :new_value) }
        .to change { config[:key] }.from(:value).to(nil)
    end

    it 'yields itself' do
      expect { |b| config.configure!(&b) }.to yield_with_args(config)
    end

    it 'yields configured self' do
      options = { key1: :value, key2: :value }

      config.configure!(**options) { |c| expect(c.to_h).to eq options }
    end

    it 'returns self' do
      expect(config.configure!).to eql config
    end
  end

  describe '#each' do
    include_context 'with configuration'

    it 'enumerates the options hash' do
      expect(config.each).to contain_exactly(*options.each)
    end
  end

  describe '#reset!' do
    include_context 'with configuration'

    it 'resets options hash' do
      expect { config.reset! }.to change { config.to_a }.to be_empty
    end
  end

  describe '#to_a' do
    include_context 'with configuration'

    it 'returns the configured options as an array' do
      expect(config.to_a).to eq options.to_a
    end
  end

  describe '#to_h' do
    include_context 'with configuration'

    it 'returns the configured options as a hash' do
      expect(config.to_h).to eq options
    end
  end
end
