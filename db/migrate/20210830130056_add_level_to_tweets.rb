class AddLevelToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :level, :string
  end
end
