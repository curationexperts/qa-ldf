shared_examples 'an ldf model' do
  before do
    unless defined?(model)
      raise ArgumentError,
            "#{model} must be defined with `let(:model)` before " \
            'using Qa::LDF::Model shared examples.'
    end
  end
end
