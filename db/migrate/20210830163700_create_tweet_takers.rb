class CreateTweetTakers < ActiveRecord::Migration[6.1]
  def change
    create_table :tweet_takers do |t|
      t.references :tweet, foreign_key: true
      t.references :taker, foreign_key: {to_table: :users} 
      t.timestamps
    end
  end
end
