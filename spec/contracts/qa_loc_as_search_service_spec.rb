require 'spec_helper'
require 'qa/authorities/loc'

# We need to guarantee `Loc.subauthority_for('names')` behaves like a search
# service
describe Qa::Authorities::Loc do
  subject(:search_service) { described_class.subauthority_for('names') }
  before do
    # an empty response for 'tove'
    stub_request(:get, 'http://id.loc.gov/search/?format=json&'\
                       'q=tove&q=cs:http://id.loc.gov/authorities/names')
      .with(headers: { 'Accept' => 'application/json' })
      .to_return(status: 200, body: '[]', headers: {})

    # real responses from fixtures
    search_config.each do |search|
      stub_request(:get, 'http://id.loc.gov/search/?format=json' \
                         "&q=#{search[:query]}&q=cs:" \
                         'http://id.loc.gov/authorities/names')
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(status: 200, body: search[:body], headers: {})
    end
  end

  let(:search_config) do
    [
      { query: 'moomin', body: '[]', result: [] }, # an empty body
    ]
  end

  let(:searches) do
    search_config.each_with_object({}) do |search, hsh|
      hsh[search[:query]] = search[:result]
    end
  end

  it_behaves_like 'an ldf search service'
end
