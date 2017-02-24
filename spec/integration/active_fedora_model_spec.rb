require 'spec_helper'
require 'active_fedora'

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

  xit 'value can retrieve its graph from the cache' do
    af_model.programmer = [value_uri]
  end
end
