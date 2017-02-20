require 'spec_helper'

##
# A fake version of `Qa::LDF::SearchService`.
#
# Configure with a hash of queries and responses to provide behavior.
#
# @example
#   service = FakeSearchService.new do |service|
#     service.queries['a query'] =
#       [{ id: 'http://example.com/an_id', key: 'value' }]
#   end
#
#   service.query('a query')
#   # => [{ id: 'http://example.com/an_id', key: 'value' }]
#
class FakeSearchService
  attr_accessor :queries

  def initialize
    @queries = {}
    yield self if block_given?
  end

  def search(query)
    queries[query] || {}
  end
end

describe FakeSearchService do
  subject(:search_service) do
    described_class.new { |service| service.queries = searches }
  end

  subject(:searches) do
    { 'a fake query' => [{ id: 'http://example.com/an_id', key: 'value' }] }
  end

  it_behaves_like 'an ldf search service'
end
