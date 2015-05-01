class FitbitAuthController < ApplicationController
  def index
  end
  
  def make_request
    # The request is made to Fitbit

  end
  def get_response
    # Callback from Fitbit Oauth

    # Oauth Access Credentials
    oauth_token = params[:oauth_token]
    oauth_verifier = params[:oauth_verifier]

    # User Information and User Access Credentials
    fitbit_data  = request.env['omniauth.auth']

    # Get User Activity Information
    activities = get_user_activities(fitbit_data)

    render json:activities
  end

private
  def get_user_activities(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user_secret = fitbit_data["credentials"]["secret"]
    user_token = fitbit_data["credentials"]["token"]

    # Store this information in you user model for
    # logins in the future.
    client = Fitgem::Client.new({
      consumer_key: '978d0a72a55a709a67e26868770d6131',
      consumer_secret: '0537b84f3605af1716d4790bcf6d0bc7',
      token: user_token,
      secret: user_secret,
      user_id: fitbit_user_id,
    })

    # Reconnects existing user using the information above
    access_token = client.reconnect(user_token, user_secret)

    # client.activities_on_date('2015-03-25') <- Specific Date
    client.activities_on_date('today')
  end
end
