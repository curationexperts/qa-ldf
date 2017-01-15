require 'spec_helper'

describe Qa::LDF do
  it 'has a version' do
    expect(described_class::VERSION.to_str).to be_a String
  end
end
