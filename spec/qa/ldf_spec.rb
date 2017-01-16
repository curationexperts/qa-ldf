require 'spec_helper'

describe Qa::LDF do
  subject(:mod) { described_class }

  it 'has a version' do
    expect(mod::VERSION.to_str).to be_a String
  end

  describe '#version' do
    it 'returns VERISON' do
      expect(mod.version).to eql mod::VERSION
    end
  end

  describe '.config' do
    it 'defaults to an empty config' do
      expect(mod.config).not_to be_any
    end

    context 'when configured' do
      before { mod.configure!(**options) }

      let(:options) { { opt: :value, opt2: :value2 } }

      it 'returns the configuration instance' do
        expect(mod.config.to_h).to eq options
      end
    end
  end

  describe '#configure!' do
    it 'dispatches arguments to the configuration instance' do
      opts  = { opt: :value }
      block = proc {}

      expect(Qa::LDF::Configuration.instance)
        .to receive(:configure!).with(**opts, &block).once

      mod.configure!(**opts, &block)
    end
  end
end
