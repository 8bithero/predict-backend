require "rails_helper"

describe PredictionsController, type: :routing do
  describe "routing" do
    it "routes to #prediction" do
      expect(:get => "/prediction").to route_to("predictions#prediction")
    end
  end
end
