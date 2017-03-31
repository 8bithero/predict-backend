require "rails_helper"

describe PredictionService do
  subject { described_class.new(prediction_term) }

  context "when prediction term is provided" do
    let(:prediction_term) { "CHANGEME" }

    it "uses provided prediction term" do
      expect(subject.prediction_term).to eq "CHANGEME"
    end
  end

  context "when prediction term is NOT provided" do
    subject { described_class.new }

    it "uses default prediction term" do
      expect(subject.prediction_term).to eq "DEFEATS"
    end
  end

  describe "#call" do
    let(:prediction_term) { "DEFEATS" }

    context "given valid parameters" do
      let(:test_string) { "Virtus Pro & Ninjas in Pyjamas" }

      it "is successful" do
        expect(subject.call(team_string: test_string).success?).to be true
      end

      it "returns the correct value" do
        expect(subject.call(team_string: test_string).value).to eq "24"
      end
    end

    context "given invalid parameters" do
      let(:test_string) { "No ampersand separator" }

      it "is unsuccessful" do
        expect(subject.call(team_string: test_string).success?).to be false
      end

      it "returns a ServiceErrorResult" do
        expect(subject.call(team_string: test_string).errors).to eq(:format => ['Invalid team name format. Example format: "First Name & Second Name"'])
      end
    end
  end
end
