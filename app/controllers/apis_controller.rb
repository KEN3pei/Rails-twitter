class ApisController < ApplicationController
  
  def index(word = params[:word])

    filter = "filter:images min_replies:10 min_retweets:500 min_faves:500 exclude:retweets"
    filter_word = word + filter
    # binding.pry
    query = URI.encode_www_form_component(filter_word)
    serches = twitter.__send__(:perform_get, '/1.1/search/tweets.json?q=' + query + '&lang=ja&result_type=recent&count=10')
    trands = twitter.__send__(:perform_get, '/1.1/trends/place.json?id=23424856')
    # binding.pry
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
    @favourites_count = []
    @serches = []
    
    i = 0
    while serches_text = serches.dig(:statuses, i, :text) do
        @serches.push(serches_text.to_s)
        
        favourites_count = serches.dig(:statuses, i, :favorite_count)
        @favourites_count.push(favourites_count.to_s(:delimited))
        
        urls = serches.dig(:statuses, i, :entities, :urls, 0, :url)
        if urls.nil?
          urls = serches.dig(:statuses, i, :entities, :media, 0, :url)
          if urls.nil?
              @urls.push(nil)
          end
          @urls.push(urls)
        else
          @urls.push(urls)
        end
        
        i += 1
    end
    
   
  end
  
  def serch
    word = serch_params
    redirect_to '/apis/index?word=' + word
    # binding.pry
  end
  
  private 
    def serch_params
        params[:word]
    end
  
  
  
end
