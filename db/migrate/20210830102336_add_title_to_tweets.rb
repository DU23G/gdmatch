class AddTitleToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :hosttime, :datetime
  end
end
