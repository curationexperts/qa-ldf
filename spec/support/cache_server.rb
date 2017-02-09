require 'sham_rack'

require 'linked_data_fragments/cache_server'
require 'linked_data_fragments/repository'

shared_context 'with cache server' do
  let(:server_endpoint) { 'http://ldcache.example.com/' }

  before(:context) do
    server_endpoint = 'ldcache.example.com'

    ShamRack
      .at(server_endpoint)
      .mount(LinkedDataFragments::CacheServer::APPLICATION)

    Qa::LDF.configure! do |config|
      config[:endpoint] = "http://#{server_endpoint}"
    end
  end

  after(:context) do
    ShamRack.reset
    Qa::LDF::Configuration.instance.reset!
  end
end
