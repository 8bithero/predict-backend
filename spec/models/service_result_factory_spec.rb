require "rails_helper"

describe ServiceResultFactory do
  describe "::from_value" do
    subject { described_class.from_value("Foo") }

    it "returns a service value result" do
      expect(subject).to be_a ServiceValueResult
    end
  end

  describe "::from_errors" do
    subject { described_class.from_errors(name: ["too shiny"]) }

    it "returns a service error result" do
      expect(subject).to be_a ServiceErrorResult
    end
  end

  describe "::from_value_and_errors" do
    subject { described_class.from_value_and_errors("Foo", errors) }

    context "given empty errors" do
      let(:errors) { {} }

      it "returns a service value result" do
        expect(subject).to be_a ServiceValueResult
      end
    end

    context "given errors" do
      let(:errors) { { name: ["too shiny"] } }

      it "returns a service error result" do
        expect(subject).to be_a ServiceErrorResult
      end
    end
  end
end
