class ApplicationController < ActionController::Base
  
  require 'oauth' 
  require 'json'  
  require "active_support/core_ext/numeric/conversions"
  
  protect_from_forgery with: :exception
  
  private
    def twitter
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET'] 
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
  
end
