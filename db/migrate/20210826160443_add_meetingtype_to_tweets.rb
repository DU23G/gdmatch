class AddMeetingtypeToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :meetingtype, :string
  end
end
