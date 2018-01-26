class Rest::SessionsController < ApplicationController

  def login
    response = HTTParty.post("#{SERVER_HOST}/rest/verify/#{params[:email]}",
      :body => {
        image: params[:image]
      }.to_json,
      :headers => {
        'Content-Type' => 'application/json',
        'User-Agent' => request.headers["User-Agent"]
      }
    )

    render status: response.code, json: { message: response.message }
  end
end
