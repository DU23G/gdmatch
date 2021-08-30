class AddHumanToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :human, :string
  end
end
