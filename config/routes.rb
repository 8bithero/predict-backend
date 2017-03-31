Rails.application.routes.draw do
  get '/prediction', to: 'predictions#prediction'
end
