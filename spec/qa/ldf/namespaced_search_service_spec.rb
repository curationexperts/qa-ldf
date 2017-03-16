require 'spec_helper'

require 'qa/ldf/namespaced_search_service'

describe Qa::LDF::NamespacedSearchService do
  it_behaves_like 'an ldf search service'

  subject(:search_service) do
    described_class.new do |service|
      service.namespace      = namespace
      service.parent_service = fake_service
    end
  end

  let(:namespace)       { 'http://example.com/ns/' }
  let(:parent_searches) { { query => parent_response } }
  let(:parent_response) { [{ 'id' => 'id', 'key' => 'value' }] }
  let(:searches)        { { query => response } }
  let(:query)           { 'tove' }
  let(:response)        { [{ 'id' => namespace + 'id', 'key' => 'value' }] }

  let(:fake_service) do
    FakeSearchService.new { |service| service.queries = parent_searches }
  end
end
