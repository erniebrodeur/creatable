require 'spec_helper'
class CreatableHarness
  extend Creatable
end

describe CreatableHarness do
  describe 'Class method signatures' do
    it { expect(described_class).to respond_to(:attribute).with_keywords :name, :type, :kind_of }
    it { expect(described_class).to respond_to(:attributes).with(0).arguments }
    it { expect(described_class).to respond_to(:create) } # TODO: match this against 'any args' or some other form of matcher
  end

  it { expect(described_class.ancestors).to include(Creatable) }

  describe "::attributes" do
    it { expect(described_class.attributes).to be_a_kind_of Array}
  end

  describe "::attribute" do
    let(:name) { 'a_name' }
    let(:type) { 'accessor' }
    let(:kind_of) { String }
    let(:params) { { name: name, type: type, kind_of: kind_of } }

    context "when the parameter name is not a symbol" do
      before { params[:name] = 'test' }

      it "is expected to convert it to symbol" do
        described_class.attribute params
        expect(described_class.attributes).to include(:test)
      end
    end

    context "when the parameter name is not supplied" do
      let(:name) { nil }

      it { expect { described_class.attribute params }.to raise_error(ArgumentError, 'name is a required parameter') }
    end

    context "when the parameter kind_of is not supplied" do
      let(:kind_of) { nil }

      it { expect { described_class.attribute params }.to raise_error(ArgumentError, 'kind_of is a required parameter') }
    end

    context "when the parameter type is not supplied" do
      let(:type) { nil }

      it { expect { described_class.attribute params }.to raise_error(ArgumentError, "type must be of type: 'accessor', 'reader', or 'writer'") }
    end

    context "when the type is supplied something other than [accessor, reader, writer]" do
      let(:types) { ['accessor', 'reader', 'writer'] }

      let(:type) { 'not_a_thing' }

      it { expect { described_class.attribute params }.to raise_error(ArgumentError, "type must be of type: 'accessor', 'reader', or 'writer'") }
    end

    it "is expected to add the value to attributes" do
      params[:name] = :test
      described_class.attribute params
      expect(described_class.attributes).to include(:test)
    end
  end

  describe "::creatable" do
    context "when a parameter is supplied" do
      it "is expected to set the value of @parameter to the value supplied"
    end
  end
end

# describe 'Signatures' do
#   it { expect(described_class).to respond_to(:create).with_keywords(*described_class.attributes) }
# end

# shared_examples 'create' do
#   described_class.attributes.each do |verb|
#     # context "when the parameter #{verb} is provided" do
#       it "it is expected to set an instance variable named @#{verb} to the value provided." do
#         c = described_class.create(verb => 'value')
#         expect(c.send(verb)).to eq 'value'
#       end
#     end
#   end

#   it 'is expected to return an instance of self.'
# end
