require 'sham_rack'

require 'linked_data_fragments/cache_server'
require 'linked_data_fragments/repository'

shared_context 'with cache server' do
  before(:context) do
    ShamRack
      .at('ldcache.example.com')
      .mount(LinkedDataFragments::CacheServer::APPLICATION)
  end
end
