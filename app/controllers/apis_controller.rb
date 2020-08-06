class ApisController < ApplicationController
  def index
    
    require 'oauth' 
    require 'json'  
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "DnmQm1CVqj2S2GiFEFN3Y1DQO"
      config.consumer_secret     = "MNXWytCkBTyYh9FJhfBzPVeorI5D5U3nmVxPiOo9qDjDDjkW9S"
      config.access_token        = "962305297489444865-KnFDl9zAvdGQqr7x2WSeR7jn4AiqjnS"
      config.access_token_secret = "V0LRYiU9WKY4PQeP0l9BClF8B8YYR5x1de3HQkvW29EHf"
    end
    
    # これでリストが取れる
    # client.user_timeline.each { |list| p list.slug } 
    
    # 全てのfollower
    # fs = []
    # client.followers.each { |follower| fs.push(follower.name) }
    
    #投稿
    # client.update("rails test now")
    
    # rate_limit_status = client.__send__(:perform_get, '/1.1/application/rate_limit_status.json')
    # rate_limit_status[:resources][:search][:"/search/tweets"]
    
    # trands = client.__send__(:perform_get, '/1.1/trends/place.json?id=23424856')
    # trands[0][:trends][1][:name]
    
    # query = "野球"
    query = "野球 filter:images min_replies:10 min_retweets:500 min_faves:500 exclude:retweets"
    # query = "野球 filter:images exclude:retweets"
    query = URI.encode_www_form_component(query)
    serches = client.__send__(:perform_get, '/1.1/search/tweets.json?q=' + query + '&lang=ja&result_type=recent&count=10')
    # serches[:statuses][1][:favorite_count]
    # serches[:statuses][1][:user][:favourites_count]
    
    @favourites_count = []
    for i in 0..9 do 
        favourites_count = serches[:statuses][i][:favorite_count]
        @favourites_count.push(favourites_count.to_i)
    end
    
    @serches = []
    for i in 0..9 do 
      serches_text = serches[:statuses][i][:text]
      @serches.push(serches_text.to_s)
    end
    
    
  end
end
