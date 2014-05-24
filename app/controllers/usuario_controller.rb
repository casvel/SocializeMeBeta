class UsuarioController < ApplicationController

  def prepare_access_token_twitter(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new("rkKwlnKABUEmWHJhhP1YBQx97",
                                   "BFHbmzL5I1LZdR6SJbL8YlmCtvgDet4xyxaSLIYe6ZRxoc0uO8",
                                   {:site => "http://api.twitter.com"})

    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token,
                   :oauth_token_secret => oauth_token_secret
    }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    return access_token
  end

  def index
    auth = current_user.authentications.where(provider: 'twitter').first
    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.

    access_token = prepare_access_token_twitter(auth['token'], auth['secret'])
    # use the access token as an agent to get the home timeline
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=30")
    #puts( response )
    @tweets  = JSON.parse(response.body)

    # render :json => response.body
  end

end