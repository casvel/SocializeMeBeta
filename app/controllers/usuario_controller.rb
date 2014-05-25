class UsuarioController < ApplicationController

  def self.tweet_format(plain_tweet)
    new_tweet = ''

    i = 0
    while i < plain_tweet.length do
      puts i

      if i > 0 and plain_tweet[i-1] == '#'
        hash = ''
        while i < plain_tweet.length and plain_tweet[i] != ' ' do
          hash << plain_tweet[i]
          i += 1
        end

        new_tweet << "<a href=\"#{hash}\"> #{hash} </a>"
      end

      if i < plain_tweet.length
        new_tweet << plain_tweet[i]
        i += 1
      end
    end

    return new_tweet
  end

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

  def home_timeline(num, auth)
    access_token = prepare_access_token_twitter(auth['token'], auth['secret'])
    # use the access token as an agent to get the home timeline
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=#{num}")
    tweets  = JSON.parse(response.body)
    return tweets
  end

  def user_timeline(screen_name, num, auth)
    access_token = prepare_access_token_twitter(auth['token'], auth['secret'])
    # use the access token as an agent to get the home timeline
<<<<<<< HEAD

    if screen_name
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=#{num}")
    else
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=#{num}")
    end

    tweets  = JSON.parse(response.body)
    return tweets
  end

  def index
    auth = current_user.authentications.where(provider: 'twitter').first
    @home_tweets = home_timeline(30, auth)
    @user_tweets = user_timeline(nil, 30, auth)
=======
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=30")
    #puts( response )
    @tweets  = JSON.parse(response.body)

    # render :json => response.body
>>>>>>> remotes/origin/Edgar
  end

end