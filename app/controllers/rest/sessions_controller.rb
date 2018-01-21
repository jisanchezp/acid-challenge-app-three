class Rest::SessionsController < ApplicationController

  def login
    response = HTTParty.post("#{SERVER_HOST}/rest/verify/#{params[:email]}",
      :body => {
        image: params[:image]
      }.to_json,
      :headers => {
        'Content-Type' => 'application/json'
      }
    )

    render json: response
  end
end
