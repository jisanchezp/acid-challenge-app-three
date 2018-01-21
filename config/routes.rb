Rails.application.routes.draw do
  namespace :rest, defaults: {format: 'json'} do
    post 'login/', to: 'sessions#login'
  end
end
