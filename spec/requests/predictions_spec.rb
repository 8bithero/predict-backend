require "rails_helper"

describe "Predictions", type: :request do
  let(:parameters) {
    {
      format: :json,
      teams: team_string,
    }
  }
  let(:headers) { { "CONTENT_TYPE" => "application/json" } }

  describe "prediction" do
    context "teams string is provided" do
      context "with correct format" do
        let(:team_string) { "Virtus Pro & Ninjas in Pyjamas" }

        it "returns a 200 (OK) HTTP status code" do
          get prediction_path, params: parameters, headers: headers
          expect(response).to have_http_status(200)
        end

        it "returns JSON with the correct value" do
          get prediction_path, params: parameters, headers: headers
          expect(json).to be_a Hash
          expect(json).to include("score" => "24")
        end

        it "does not contain errors" do
          get prediction_path, params: parameters, headers: headers
          expect(json).to be_a Hash
          expect(json).to_not include("errors")
        end
      end

      context "with incorrect format" do
        let(:team_string) { "No ampersand separator" }

        it "returns an 400 (BAD REQUEST) HTTP status code" do
          get prediction_path, params: parameters, headers: headers
          expect(response).to have_http_status(400)
        end

        it "returns JSON with the correct error" do
          get prediction_path, params: parameters, headers: headers
          expect(json).to be_a Hash
          expect(json).to include("errors" => {
            "format" =>
              [ 'Invalid team name format. Example format: "First Name & Second Name"']
            }
          )
        end

        it "does not contain a score" do
          get prediction_path, params: parameters, headers: headers
          expect(json).to be_a Hash
          expect(json).to_not include("score")
        end
      end
    end

    context "teams string is NOT provided" do
      let(:parameters) { { format: :json } }

      it "returns an 400 (BAD REQUEST) HTTP status code" do
        get prediction_path, params: parameters, headers: headers
        expect(response).to have_http_status(400)
      end

      it "returns JSON with the correct error" do
        get prediction_path, params: parameters, headers: headers
        expect(json).to be_a Hash
        expect(json).to include("errors" => {
          "format" =>
            [ 'Invalid team name format. Example format: "First Name & Second Name"']
          }
        )
      end
    end
  end
end
