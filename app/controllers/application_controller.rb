class ApplicationController < ActionController::API
  SERVER_HOST = (Rails.env.development? or Rails.env.test?) ?  "http://localhost:3001" : "https://login-jisanchez.herokuapp.com"
end
