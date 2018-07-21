require 'spec_helper'

describe Creatable do
  describe 'Class methods' do
    describe 'Signatures' do
      it { expect(described_class).to respond_to(:create).with_keywords(*described_class.attributes) }
    end

    shared_examples 'create' do
      described_class.attributes.each do |verb|
        context "when the parameter #{verb} is provided" do
          it "it is expected to set an instance variable named @#{verb} to the value provided." do
            c = described_class.create(verb => 'value')
            expect(c.send(verb)).to eq 'value'
          end
        end
      end

      it 'is expected to return an instance of self.'
    end

    include_examples 'create'
  end
end
