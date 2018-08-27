require 'spec_helper'

describe Creatable do
  before do
    class Harness
      include Creatable

      attribute name: 'an_attribute', type: 'accessor', kind_of: String
    end
  end

  # makes our tests sensable, even though we changed what exactly we are tracking
  subject { Harness }

  let(:described_class) { Harness }
  let(:new_obj) { described_class.new }
  let(:params) { { name: 'an_attribute', type: 'accessor', kind_of: String } }

  it { expect(described_class.ancestors).to include(described_class) }
  it { is_expected.to respond_to(:attributes).with(0).arguments }

  describe "::attributes" do
    it "is expected to return the attributes" do
      expect(new_obj.attributes).to eq params
    end
  end
end
