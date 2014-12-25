class TweetsController < ApplicationController
  before_action :authenticate_user!
  TIME_LIMIT = Time.now.to_i - 31536000

  def index
    if current_user.tweets.count == 0
      render :show
      Thread.new do
        current_user.status = 0
        current_user.save
        #set up Twitter client
        client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "fY3pp25QT9wZocZg2CJeJXEu0"
            config.consumer_secret     = "yh7EVvIwkGzW1W49wsjXY7f0LXdnDVWoGlTtVwtC9ZJnC3NMJK"
            config.access_token        = current_user.token 
            config.access_token_secret = current_user.secret 
        end

        #collect all tweets
        @tweets = collect_with_max_id do |max_id|
          options = {count: 200, include_rts: false, exclude_replies: true}
          options[:max_id] = max_id unless max_id.nil?
          client.user_timeline(current_user, options)
        end

        current_user.status = 1
        current_user.save

        #filter out tweets older than a year
        @tweets.delete_if {|key, value| key['created_at'].to_i < TIME_LIMIT }
      
        #sort all tweets    
        @tweets.sort_by! { |key, value| key["favorite_count"] }.reverse!
        i = 2
        #create tweets in database for top 12
        @tweets[0...12].each do |tweet|
          Tweet.create(content: tweet['text'], 
                        user_id: current_user.id, 
                        date: tweet['created_at'], 
                        favorites: tweet['favorites_count'],
                        url: "https://twitter.com/" + current_user.uid + "/status/"+ tweet['id'].to_s
                        )

          temp_words = []
          max = 0

          @words = tweet['text'].split(" ").each do |word|
            next if word[0] == "@"
            next if word[0, 5] == "https" || word[0, 4] == "http"

            if word.length > max 
              temp_words.unshift(word)
              max = word.length
            end
          end
          
          @gif = nil

          first = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=" + temp_words[0] + "&api_key=dc6zaTOxFJmzC")['data'] if temp_words[0]
          
          if first != []
            @gif = first[0]['images']['original']['url']
          elsif temp_words[1]
            second = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=" + temp_words[1] + "&api_key=dc6zaTOxFJmzC")['data'] 
            if second != []
              @gif = second[0]['images']['original']['url']
            end
          end

          if @gif == nil
            @gif = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=grumpy+cat&api_key=dc6zaTOxFJmzC")['data'][0]['images']['original']['url']
          end

          temp_tweet = Tweet.find_by(content: tweet['text'])
          Gif.create(tweet_id: temp_tweet['id'], url: @gif)
              
        end 

        #calculate min
        min = 10000
        current_user.tweets.each do |tweet|
          if tweet.content.length < min
            min = tweet.content.length
            @temp_min = tweet
          end
        end
        @temp_min.importance = 1
        @temp_min.save
        
        if current_user.tweets[0, 2].include?(@temp_min)
          current_user.tweets[1, 3].each do |tweet|
            tweet.importance = 2
            tweet.save
          end
        else
          current_user.tweets[0, 2].each do |tweet|
            tweet.importance = 2
            tweet.save
          end
        end

        current_user.tweets.each do |tweet|
          unless tweet.importance
            tweet.importance = 3 
            tweet.save
          end
        end
        samples = ["A year in the life of", "365 days of", "The personal zzzine of", "The totally secret journal of", "Baller tweets courtesy of", "The Twitter game of", "12 Reasons you'll never be as real as", "The Tweet-museum of"]
        current_user.style_id = rand(5) + 1
        current_user.title = samples[rand(8) + 1] + " " + current_user.uid
        current_user.status = 2
        current_user.save   
      end
    else
      redirect_to "/view/#{current_user.uid}"
    end
  end
  

  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    test = []
    collection += response
    collection.flatten if collection.count > 2800
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end
end

