class PredictionsController < ApplicationController
  # GET /prediction?teams="name string & example"
  def prediction
    service = PredictionService.new(Rails.configuration.x.prediction_word)
    result = service.call(team_string: prediction_params[:teams])

    if result.success?
      render json: { score: result.value }, status: 200
    else
      render json: { errors: result.errors }, status: 400
    end
  end

  private
    def prediction_params
      params.permit(:teams)
    end
end
