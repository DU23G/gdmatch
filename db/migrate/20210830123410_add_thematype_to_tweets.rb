class AddThematypeToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :thematype, :string
  end
end
