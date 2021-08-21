class TweetsController < ApplicationController
  
    def index
        @tweet = Tweet.new

        @tweets = Tweet.all
    end

    def create
        tweet = Tweet.new(tweet_params)

        if tweet.save
          redirect_to :action => "index"
        else
          redirect_to :action => "index"
        end
    end

    private
      def tweet_params
        params.require(:tweet).permit(:thema, :meeting, :comment)
    end

end
