require "rails_helper"

describe ServiceValueResult do
  subject { described_class.new(value) }

  let(:value) { "Foo" }

  describe "::new" do
    context "given a non-nil value" do
      it { is_expected.to be_a described_class }
    end

    context "given a nil value" do
      let(:value) { nil }
      it "raises an error" do
        expect { subject }.to raise_error "cannot have a successful result with nil value"
      end
    end
  end

  describe "#success?" do
    it { is_expected.to be_success }
  end

  describe "#fail?" do
    it { is_expected.not_to be_fail }
  end

  describe "#map" do
    subject { described_class.new(value).map { |s| s + "Bar" } }

    it { is_expected.to be_an_instance_of(described_class) }

    it "modifies the instance value" do
      expect(subject.value).to eq("FooBar")
    end
  end
end
