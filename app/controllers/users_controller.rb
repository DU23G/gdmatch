class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show]
  
  def index
    @users=User.all
  end

  def show
    @user = User.find(params[:id]) 

    c = [] #まず空の配列を準備（必須）、配列が2個にならないように注意
    @followings = @user.followings
    @followers = @user.followers
    c.push(@followings)
    c.push(@followers) #cの配列の中身に配列を入れる。（2次元状態）
    @users = c.flatten! #次元削減（1次元へ）

    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
end