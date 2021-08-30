class AddLimittimeToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :limittime, :datetime
  end
end
