require 'spec_helper'

describe Creatable do
  subject { Harness.new }

  before do
    class Harness
      include Creatable

      attribute name: 'an_attribute', type: 'accessor', kind_of: String
    end
  end

  let(:described_class) { Harness }
  let(:new_obj) { described_class.new }
  let(:params) { { name: 'an_attribute', type: 'accessor', kind_of: String } }

  it { is_expected.to be_a_kind_of Creatable } # rubocop: disable RSpec/DescribedClass
  it { is_expected.to respond_to(:attributes).with(0).arguments }
  it { is_expected.to respond_to(:attribute_names).with(0).arguments }
  it { is_expected.to respond_to(:to_parameters).with(0).arguments }

  describe "::attributes" do
    it "is expected to return the attributes" do
      expect(new_obj.attributes).to eq [params]
    end
  end

  describe "::attribute_names" do
    it { expect(new_obj.attribute_names).to be_a_kind_of Array }

    it "is expected to return the names of each attribute" do
      expect(new_obj.attribute_names).to eq [params[:name]]
    end
  end

  describe "::to_parameters" do
    let(:result) { new_obj.to_parameters }

    it { expect(result).to be_a_kind_of(Hash) }

    it "include the k/v of the attribute" do
      expect(result).to eq("an_attribute" => nil)
    end
  end
end
