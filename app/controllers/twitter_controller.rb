class TwitterController < ApplicationController

  # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
  def prepare_access_token(oauth_token, oauth_token_secret)
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

end