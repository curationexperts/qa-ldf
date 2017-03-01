require 'spec_helper'
require 'active_fedora'

# Tests the main boundaries to ActiveFedora. This should be considered
# incomplete, at best. We haven't exhastively analyzed relevant AF behavior.
describe 'ActiveFedora integration' do
  subject(:af_model) { af_model_class.new }

  let(:value_uri) { RDF::URI('http://id.loc.gov/authorities/names/n83175996') }
  let(:af_model_class) do
    Class.new(ActiveFedora::Base) do
      property :programmer,
               predicate:  RDF::Vocab::MARCRelators.prg,
               class_name: Qa::LDF::Model
    end
  end

  before { af_model.programmer = [value_uri] }

  define :be_term do |expected|
    match { |actual| expect(actual.to_term).to eq expected }
  end

  it 'builds value as a model' do
    expect(af_model.programmer)
      .to contain_exactly(an_instance_of(Qa::LDF::Model))
  end

  it 'builds value with correct rdf term' do
    af_model.programmer = [value_uri]
    expect(af_model.programmer).to contain_exactly(be_term(value_uri))
  end

  describe 'retrieving from the server' do
    include_context 'with cache server'

    let(:statement) do
      RDF::Statement(value_uri, RDF::URI('http://example.com/p'), :o)
    end

    let(:stub) do
      stub_request(:get, value_uri.to_s)
        .to_return(body:    statement.to_ntriples,
                   headers: { 'Content-Type' => 'text/turtle' })
    end

    # touch the stub
    before { stub }

    it 'value can retrieve its graph from the cache' do
      af_model.programmer = [value_uri]

      af_model.programmer.first.fetch
      expect(stub).to have_been_requested
    end
  end
end
