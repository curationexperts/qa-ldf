require 'spec_helper'

describe Qa::LDF::Model do
  subject(:model) { described_class.new(id) }
  let(:id)        { 'http://example.com/authority/moomin' }

  it_behaves_like 'an ldf model'
end
