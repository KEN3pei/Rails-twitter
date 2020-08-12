class ApisController < ApplicationController
  def index
    
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "DnmQm1CVqj2S2GiFEFN3Y1DQO"
        config.consumer_secret     = "MNXWytCkBTyYh9FJhfBzPVeorI5D5U3nmVxPiOo9qDjDDjkW9S"
        config.access_token        = "962305297489444865-KnFDl9zAvdGQqr7x2WSeR7jn4AiqjnS"
        config.access_token_secret = "V0LRYiU9WKY4PQeP0l9BClF8B8YYR5x1de3HQkvW29EHf"
      end
    
    # rate_limit_status = client.__send__(:perform_get, '/1.1/application/rate_limit_status.json')
    # rate_limit_status[:resources][:search][:"/search/tweets"]
    
    trands = client.__send__(:perform_get, '/1.1/trends/place.json?id=23424856')
    
    filter = "filter:images min_replies:10 min_retweets:500 min_faves:500 exclude:retweets"
    query = "野球" + filter
    query = URI.encode_www_form_component(query)
    serches = twitter.__send__(:perform_get, '/1.1/search/tweets.json?q=' + query + '&lang=ja&result_type=recent&count=10')
    serches = client.__send__(:perform_get, '/1.1/search/tweets.json?q=' + query + '&lang=ja&result_type=recent&count=10')
    # lang=ja
    # lang=zh
    # lang=en
    # lang=fr
    # lang=es
    
    @trands = []

    for i in 0..49 do 
        data = []
        data.push(trands.dig(0, :trends, i, :name))
        data.push(trands.dig(0, :trends, i, :url))
        trand = trands.dig(0, :trends, i, :tweet_volume).try(:to_s, :delimited)
        data.push(trand)
        @trands.push(data)
    end
    
    @urls = []
    for i in 0..9 do 
        urls = serches.dig(:statuses, i, :entities, :urls, 0, :url)
        if urls.nil?
          urls = serches.dig(:statuses, i, :entities, :media, 0, :url)
          @urls.push(urls)
        else
          @urls.push(urls)
        end
    end
    
    @favourites_count = []
    for i in 0..9 do 
        favourites_count = serches.dig(:statuses, i, :favorite_count)
        @favourites_count.push(favourites_count.to_s(:delimited))
    end
    
    @serches = []
    for i in 0..9 do 
      serches_text = serches.dig(:statuses, i, :text)
      @serches.push(serches_text.to_s)
    end
    
    
  end
end
