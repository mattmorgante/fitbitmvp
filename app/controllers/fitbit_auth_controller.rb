class FitbitAuthController < ApplicationController
  
  # this is the callback information from fitbit
  def get_response
    # Access Credentials
    oauth_token = params[:oauth_token]
    oauth_verifier = params[:oauth_verifier]

    # creates a variable we can pass as an argument below
    data = request.env['omniauth.auth']

    # the data we'll be receiving, activity data
    activities = get_user_activities(data)
    # our view will render a basic json object  
    render json:activities
    #activities is an object
  end

private
  # this is the information we're sending to fitbit
  def get_user_activities(data)
    fitbit_user_id = data["uid"]
    user_secret = data["credentials"]["secret"]
    user_token = data["credentials"]["token"]

    # creates a new instance of Fitgem
    client = Fitgem::Client.new({
      consumer_key: 'YOUR_CONSUMER_KEY',
      consumer_secret: 'YOUR_CONSUMER_SECRET',
      token: user_token,
      secret: user_secret,
      user_id: fitbit_user_id,
    })
    # Reconnects existing user using their credentials
    access_token = client.reconnect(user_token, user_secret)

    # specifies date range to request data from
    client.activities_on_date('today')
  end
end