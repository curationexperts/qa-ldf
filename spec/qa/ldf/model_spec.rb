require 'spec_helper'

describe Qa::LDF::Model do
  define :be_term do |expected|
    match { |actual| expect(actual.to_term).to eq expected }
  end

  let(:id)    { 'http://example.com/authority/moomin' }
  let(:label) { 'moomin' }

  describe '.from_graph' do
    let(:graph) do
      graph = RDF::Graph.new
      graph.insert(*statements)
      graph
    end

    let(:statements) do
      [RDF::Statement(RDF::URI(id),  RDF::Vocab::SKOS.prefLabel, label),
       RDF::Statement(RDF::URI(id),  RDF::Vocab::DC.title, 'Moomin Papa'),
       RDF::Statement(RDF::Node.new, RDF::Vocab::DC.title, 'Moomin Papa')]
    end

    it 'builds a model with the id as uri' do
      expect(described_class.from_graph(uri: id, graph: graph))
        .to be_term RDF::URI(id)
    end

    it 'builds a model with the label as label' do
      expect(described_class.from_graph(uri: id, graph: graph))
        .to have_attributes rdf_label: a_collection_containing_exactly(label)
    end

    it 'contains passed graph' do
      expect(described_class.from_graph(uri: id, graph: graph).statements)
        .to include(*statements)
    end
  end

  describe '.from_qa_result' do
    let(:json_hash) { { id: id, label: label, papa: 'moomin papa' } }

    it 'builds a model with the id as uri' do
      expect(described_class.from_qa_result(qa_result: json_hash))
        .to be_term RDF::URI(id)
    end

    it 'builds a model with the label as label' do
      expect(described_class.from_qa_result(qa_result: json_hash))
        .to have_attributes rdf_label: a_collection_containing_exactly(label)
    end
  end
end
