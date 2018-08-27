require 'spec_helper'
module Creatable
  describe ClassMethods do
    subject { Harness }

    before do
      class Harness
        include Creatable

        attribute name: 'an_attribute', type: 'accessor', kind_of: String
      end
    end

    let(:described_class) { Harness }
    let(:name) { 'an_attribute' }
    let(:type) { 'accessor' }
    let(:kind_of) { String }
    let(:params) { { name: name, type: type, kind_of: kind_of } }

    let(:new_obj) { described_class.new }

    describe 'Class method signatures' do
      it { expect(described_class).to respond_to(:attribute).with_keywords :name, :type, :kind_of }
      it { expect(described_class).to respond_to(:attributes).with(0).arguments }
      it { expect(described_class).to respond_to(:create) }
    end

    it { expect(new_obj).to be_a_kind_of Creatable }

    describe "::attributes" do
      it { expect(new_obj.attributes).to be_a_kind_of Hash }
    end

    describe "::attribute" do
      context "when the parameter name is not a symbol" do
        it "is expected to convert it to symbol" do
          expect(new_obj.attributes).to eq params
        end
      end

      context "when the parameter name is not supplied" do
        let(:name) { nil }

        it { expect { described_class.attribute params }.to raise_error(ArgumentError, 'name is a required parameter') }
      end

      context "when the parameter type is not supplied" do
        let(:new_obj) { described_class.create an_attribute: 'something' }

        before do
          params[:type] = nil
        end

        it "is expected to default to 'accessor'" do
          expect(new_obj).to respond_to(:an_attribute=)
        end
      end

      context "when the type is supplied something other than [accessor, reader, writer, nil]" do
        let(:type) { 'not_a_thing' }

        it { expect { described_class.attribute params }.to raise_error(ArgumentError, "type must be of type: 'accessor', 'reader', or 'writer'") }
      end

      it "is expected to add the value to attributes" do
        described_class.attribute params
        expect(described_class.attributes).to eq params
      end
    end

    describe "::creatable" do
      let(:new_obj) { described_class.create an_attribute: 'something' }

      context "when a parameter is supplied" do
        it "is expected to set the instance_value of name to the value supplied" do
          expect(new_obj.an_attribute).to eq 'something'
        end
      end

      it "is expected to return an instance of self" do
        expect(new_obj.an_attribute).to be_a_kind_of params[:kind_of]
      end
    end

    describe "a created method" do
      it "is expected to return the instance_variable of the same name" do
        new_obj = described_class.create an_attribute: 'something'
        expect(new_obj.an_attribute).to eq new_obj.instance_variable_get :@an_attribute
      end
    end

    describe "a created method=" do
      context "when the supplied value does not match kind_of" do
        it { expect { new_obj.an_attribute = :not_a_string }.to raise_error(ArgumentError, 'parameter an_attribute (Symbol) is not a kind of (String)') }
      end

      context "when the value kind_of is nil" do
        let(:kind_of) { nil }

        before { described_class.attribute params }

        it "is expected to not raise an error" do
          new_obj = described_class.create params
          expect { new_obj.an_attribute = [] }.not_to raise_error
        end
      end

      it "is expected to set the instance_variable of the same name" do
        new_obj = described_class.create an_attribute: 'this'
        new_obj.an_attribute = 'something'
        expect(new_obj.an_attribute).to eq 'something'
      end
    end
  end
end
