class GroupchatsController < ApplicationController
    before_action :authenticate_user!

    def create
      group = Group.find(params[:group_id])
      groupchat = group.groupchats.build(groupchat_params)
      groupchat.user_id = current_user.id
      if groupchat.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end
  
    private
  
      def groupchat_params
        params.require(:groupchat).permit(:content)
      end
end
