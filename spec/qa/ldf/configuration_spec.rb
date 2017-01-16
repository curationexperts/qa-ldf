require 'spec_helper'

describe Qa::LDF::Configuration do
  subject { described_class.instance }
  
  shared_context 'with configuration' do
    before { subject.configure!(**options) }

    let(:options) do
      { option: :moomin }
    end
  end

  describe '#[]' do
    include_context 'with configuration'

    it 'gives nil for unconfigured options' do
      expect(subject[:fake]).to be_nil
    end

    it 'accesses options' do
      options.each { |k, v| expect(subject[k]).to eq v }
    end
  end

  describe '#configure!' do
    it 'configures the options' do
      expect { subject.configure!(key: :value) }
        .to change { subject[:key] }.from(nil).to(:value)
    end

    it 'overrides the options' do
      subject.configure!(key: :value)

      expect { subject.configure!(key: :new_value) }
        .to change { subject[:key] }.from(:value).to(:new_value)
    end

    it 'overrides options not in new config' do
      subject.configure!(key: :value)

      expect { subject.configure!(new_key: :new_value) }
        .to change { subject[:key] }.from(:value).to(nil)
    end
    
    it 'yields itself' do
      expect { |b| subject.configure!(&b) }.to yield_with_args(subject)
    end
    
    it 'yields configured self' do
      options = {key1: :value, key2: :value}

      subject.configure!(**options) { |c| expect(c.to_h).to eq options }
    end

    it 'returns self' do
      expect(subject.configure!).to eql subject
    end
  end

  describe '#each' do
    include_context 'with configuration'
    
    it 'enumerates the options hash' do
      expect(subject.each).to contain_exactly(*options.each)
    end
  end

  describe '#to_a' do
    include_context 'with configuration'

    it 'returns the configured options as an array' do
      expect(subject.to_a).to eq options.to_a
    end
  end

  describe '#to_h' do
    include_context 'with configuration'

    it 'returns the configured options as a hash' do
      expect(subject.to_h).to eq options
    end
  end
end
