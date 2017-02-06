require 'spec_helper'
##
# @todo: Stub LDF behavior at this point. Add integration/contract tests for
#   this interface.
describe Qa::LDF::Client do
  subject(:client) { described_class.new }

  let(:uri) { 'http://id.loc.gov/authorities/subjects/sh2004002557' }

  include_context 'with cache server'
  it_behaves_like 'an ld cache client'
end
