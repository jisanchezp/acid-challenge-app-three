class ApplicationController < ActionController::API
  SERVER_HOST = Figaro.env.server_host
end
