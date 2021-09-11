class TweetsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_tweet
  after_action :set_tweet, except: [:index, :new, :create, :destroy]

    def index
      if params[:search] == nil
          @tweets= Tweet.all.page(params[:page]).per(10)
      elsif params[:search] == ''
          @tweets= Tweet.all.page(params[:page]).per(10)
      else
          @tweets = Tweet.where("thema LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(10)
      end

    end

    def new
      @tweet = Tweet.new
    end

    def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id

        if tweet.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
      @tweet = Tweet.find(params[:id])

      @remarks = @tweet.remarks
      @remark = Remark.new

      @user = @tweet.user
    end

    def edit
      @tweet = Tweet.find(params[:id])
    end

    def update
      tweet = Tweet.find(params[:id])
      if tweet.update(tweet_params)
        redirect_to :action => "show", :id => tweet.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy
      tweet = Tweet.find(params[:id])
      tweet.destroy
      redirect_to action: :index
    end

    def take
      @tweet = Tweet.find(params[:id])
      # 該当の投稿とログイン中のユーザーとの中間テーブルのレコードを作成する
      TweetTaker.create(tweet_id: @tweet.id, taker_id: current_user.id)
      # フラッシュメッセージを表示（フラッシュメッセージを表示させない場合は書かなくて大丈夫です）
      flash[:alert] = '申し込みが完了しました。'
      # 投稿の詳細ページにリダイレクト
      redirect_to action: :show
    end

    def cancel
      @tweet = Tweet.find(params[:id])
      # 中間テーブルの中から、該当の投稿とログイン中のユーザーによるレコードを抽出する
      tweet_taker = TweetTaker.find_by(tweet_id: @tweet.id, taker_id: current_user.id)
      tweet_taker.destroy
      flash[:alert] = 'キャンセルが完了しました。'
      redirect_to action: :show
    end

    private
      def tweet_params
        params.require(:tweet).permit(:thema, :meeting, :comment, :meetingtype, :hosttime, :thematype, :limittime, :level, :number)
    end

      def set_tweet
        @tweet = Tweet.find(params[:id])
    end

end
