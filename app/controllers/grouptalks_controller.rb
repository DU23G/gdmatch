class GrouptalksController < ApplicationController
    before_action :authenticate_user!

    def create
      tweet = Tweet.find(params[:tweet_id])
      grouptalk = tweet.grouptalks.build(grouptalk_params) #buildを使い、contentとtweet_idの二つを同時に代入
      grouptalk.user_id = current_user.id
      if grouptalk.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end
  
    private
  
      def grouptalk_params
        params.require(:grouptalk).permit(:content)
      end
end
