class TweetsController < ApplicationController
  

  TIME_LIMIT = Time.now.to_i - 31536000
  
  def index
    if current_user.tweets.count == 0
      #set up Twitter client
      client = Twitter::REST::Client.new do |config|
          config.consumer_key        = "fY3pp25QT9wZocZg2CJeJXEu0"
          config.consumer_secret     = "yh7EVvIwkGzW1W49wsjXY7f0LXdnDVWoGlTtVwtC9ZJnC3NMJK"
          config.access_token        = current_user.token 
          config.access_token_secret = current_user.secret 
      end

      #collect all tweets
      @tweets = collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        client.user_timeline(current_user, options)
      end

      #filter out tweets older than a year
      @tweets.delete_if {|key, value| key['created_at'].to_i < TIME_LIMIT }
    
      #sort all tweets    
      @tweets.sort_by! { |key, value| key["favorite_count"] }.reverse!

      #create tweets in database for top 20
      @tweets[0..12].each do |tweet|
        Tweet.create(content: tweet['text'], 
                      user_id: current_user.id, 
                      date: tweet['created_at'], 
                      favorites: tweet['favorites_count'],
                      )

        temp_words = []
        max = 0

        @words = tweet['text'].split(" ").each do |word|
          if word.length > max 
            temp_words.unshift(word)
            max = word.length
          end
        end
        
        @gif = nil

        [0..temp_words.length].each do |i|


        first = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=" + temp_words[0] + "&api_key=dc6zaTOxFJmzC")['data'] if temp_words[0]
        
        
        if first != []
          @gif = first[0]['embed_url']
        elsif temp_words[1]
          second = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=" + temp_words[1] + "&api_key=dc6zaTOxFJmzC")['data'] 
          if second != []
            @gif = second[0]['embed_url']
          end
        end

        if @gif == nil
          @gif = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=grumpy+cat&api_key=dc6zaTOxFJmzC")['data'][0]['embed_url'] unless @gif.class == "string"
        end

        temp_tweet = Tweet.find_by(content: tweet['text'])
        Gif.create(tweet_id: temp_tweet['id'], url: @gif)

        # if tweet.entities.hashtags
        #   tweet.entities.hashtags.each do |hashtag|
        #     Hashtag.create(title: hashtag, tweet_id: temp_tweet.id)
        #   end
        # end       
        end
      end 
    end
    render json: current_user.tweets, include: [:gif]
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    test = []
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

end

