class RemarksController < ApplicationController
    before_action :authenticate_user!

    def create
      tweet = Tweet.find(params[:tweet_id])
      remark = tweet.remarks.build(remark_params) #buildを使い、contentとtweet_idの二つを同時に代入
      remark.user_id = current_user.id
      if remark.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end
  
    private
  
      def remark_params
        params.require(:remark).permit(:content)
      end
end
