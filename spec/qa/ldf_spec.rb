require 'spec_helper'

describe Qa::LDF do
  it 'has a version' do
    expect(subject::VERSION.to_str).to be_a String
  end

  describe '#version' do
    it 'returns VERISON' do
      expect(subject.version).to eql subject::VERSION
    end
  end
  
  describe '.config' do
    it 'defaults to an empty config' do
      expect(subject.config).not_to be_any
    end

    context 'when configured' do
      before { subject.configure!(**options) }

      let(:options) { {opt: :value, opt2: :value2} }
      
      it 'returns the configuration instance' do
        expect(subject.config.to_h).to eq options
      end
    end
  end

  describe '#configure!' do
    it 'dispatches arguments to the configuration instance' do
      opts, block  = {opt: :value}, Proc.new {}

      expect(Qa::LDF::Configuration.instance)
        .to receive(:configure!).with(**opts, &block).once

      subject.configure!(**opts, &block)
    end
  end
end
