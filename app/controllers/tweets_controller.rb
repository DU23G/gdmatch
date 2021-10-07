class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  impressionist :actions=> [:show]
  # before_action :set_tweet
  after_action :set_tweet, except: [:index, :new, :create, :destroy]

    def index
      if params[:search] == nil
          @tweets= Tweet.all.page(params[:page]).per(15)
      elsif params[:search] == ''
          @tweets= Tweet.all.page(params[:page]).per(15)
      else
          # @tweets = Tweet.where("thema LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(15)

          thematype_ids = Tweet.where("thematype = ?", params[:thematype]) .pluck(:id)
          # プルダウンで選ばれたthematypeと同一のthematypeを持つレコードを取得し、そのidを全て列挙する
          
          thema_ids = Tweet.where("thema LIKE ? ",'%' + params[:search] + '%').pluck(:id)
          # thema_ids = Tweet.where("thema LIKE (?)", "#{params[:search]}").pluck(:id)
          # キーワードで検索された名前と同じthemaと同じthemaを持つレコードのidを全て列挙する
    
          @tweets = Tweet.where("id IN (?) or id IN (?)", thematype_ids, thema_ids).all.page(params[:page]).per(15)
          # submit_name_idsかproblem_name_idsに当てはまるものをtweetテーブルから探して、
          # @tweetsに代入。
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

      impressionist(@tweet, nil, unique: [:session_hash])

      @grouptalks = @tweet.grouptalks
      @grouptalk = Grouptalk.new
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

      #tweet_takerテーブルからtweet_idがこのtweetのidと同じレコードの数をカウントして数を左辺に代入
      tweettaker_tweetid_count_plusone = TweetTaker.where(tweet_id:@tweet.id).count + 1
      #tweetテーブルからこのtweetのnumberの値を左辺に代入
      tweet_number_count = @tweet.number
      # 該当の投稿とログイン中のユーザーとの中間テーブルのレコードを作成する
      if tweettaker_tweetid_count_plusone < tweet_number_count
        TweetTaker.create(tweet_id: @tweet.id, taker_id: current_user.id)
        # フラッシュメッセージを表示（フラッシュメッセージを表示させない場合は書かなくて大丈夫です）
        flash[:alert] = '申し込みが完了しました。'
        # 投稿の詳細ページにリダイレクト
        redirect_to action: :show, anchor: "groupchat" 
      else
        flash[:alert] = '満席になっているため申し込みできませんでした。'
        redirect_to action: :show
      end
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
        params.require(:tweet).permit(:thema, :meeting, :comment, :meetingtype, :hosttime, :thematype, :limittime, :level, :number, :requiredtime, :subject)
      end

      def set_tweet
        @tweet = Tweet.find(params[:id])
      end

end
