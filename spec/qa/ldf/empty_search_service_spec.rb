# coding: utf-8
require 'spec_helper'
require 'qa/ldf/empty_search_service'

describe Qa::LDF::EmptySearchService do
  it_behaves_like 'an ldf search service'

  subject(:search_service) { described_class.new }

  describe '#search' do
    it 'responds empty to arbitrary queries' do
      ['-NonSensE\ !QUERY', 'Bărăganul (Romania)'].each do |query|
        expect(search_service.search(query)).to be_empty
      end
    end
  end
end
