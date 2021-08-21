class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :thema
      t.text :meeting
      t.string :comment

      t.timestamps
    end
  end
end
