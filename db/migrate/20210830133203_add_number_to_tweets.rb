class AddNumberToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :number, :integer
  end
end
