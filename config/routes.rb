Rails.application.routes.draw do
  namespace :rest do
    get 'sessions/login'
  end
end
