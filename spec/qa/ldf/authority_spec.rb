require 'spec_helper'

describe Qa::LDF::Authority do
  subject(:authority) { described_class.new }

  let(:id) { 'Moomin' }

  describe '#all' do
    it 'is enumerable' do
      expect(authority.all).to respond_to :each
    end

    it 'enumerates the vocabulary'
  end

  describe '#find' do
    it 'returns a JSON-like hash'
  end

  describe '#search' do
    it 'searches the vocabulary'
  end
end
