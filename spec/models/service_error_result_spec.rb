require "rails_helper"

describe ServiceErrorResult do
  subject { described_class.new(value) }

  let(:value) { { name: ["too weird"] } }

  describe "::new" do
    context "given a non-empty value" do
      it { is_expected.to be_a described_class }
    end

    context "given a nil value" do
      let(:value) { nil }
      it "raises an error" do
        expect { subject }.to raise_error "cannot create an error result given a nil error object"
      end
    end

    context "given an empty value" do
      let(:value) { {} }
      it "raises an error" do
        expect { subject }.to raise_error "cannot create an error result given an empty error object"
      end
    end
  end

  describe "#success?" do
    it { is_expected.not_to be_success }
  end

  describe "#fail?" do
    it { is_expected.to be_fail }
  end

  describe "#map" do
    subject { described_class.new(value).map { |s| s + "Bar" } }

    it { is_expected.to be_an_instance_of(described_class) }

    it "does not modify the instance error" do
      expect(subject.errors).to eq(name: ["too weird"])
    end
  end
end
