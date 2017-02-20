require 'spec_helper'
##
# @todo: Stub LDF behavior at this point. Add integration/contract tests for
#   this interface.
describe Qa::LDF::Client do
  subject(:client) { described_class.new }

  let(:uri)        { 'http://id.loc.gov/authorities/subjects/sh2004002557' }
  let(:graph_stub) { RDF::Graph.new << [RDF::URI(uri), RDF.type, RDF.Property] }

  before do
    # stub the external request, this behavior is owned by the server,
    # we just allow it to make the request
    stub_request(:get, uri)
      .to_return(status:  200,
                 body:    graph_stub.dump(:ntriples),
                 headers: { 'Content-Type' =>
                            RDF::Format.for(:ntriples).content_type })
  end

  include_context 'with cache server'
  it_behaves_like 'an ld cache client'
end
