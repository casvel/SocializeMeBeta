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

    if screen_name
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=#{num}")
    else
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=#{num}")
    end

    tweets  = JSON.parse(response.body)
    return tweets
  end

  def send_tweet(texto, auth)
    access_token = prepare_access_token_twitter(auth['token'], auth['secret'])
    response = access_token.request(:post, URI.escape("https://api.twitter.com/1.1/statuses/update.json?status=#{texto}"))
    return response
  end

  def search_tweets(query, num, auth)
    access_token = prepare_access_token_twitter(auth['token'], auth['secret'])
    response = access_token.request(:get, URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=#{query}&count=#{num}"))
    return response
  end

  def index
    auth = current_user.authentications.where(provider: 'twitter').first

    texto = params[:new_tweet]
    if texto
      response = send_tweet(texto, auth)
      if response.code == '200'
        flash.now[:notice] = "Your tweet has been send succesfully!"
      else
        flash.now[:notice] = "Oops! Something went wrong"
      end
    end


    query = params[:query]
    if query
      response = search_tweets(query, 30, auth)
      if response.code == '200'
        @query_tweets = JSON.parse(response.body)
      else
        flash.now[:notice] = "Oops! Something went wrong"
      end
    end

    @home_tweets = home_timeline(30, auth)
    @user_tweets = user_timeline(nil, 30, auth)
  end

end