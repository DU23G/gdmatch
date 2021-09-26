class AddPulldownToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :requiredtime, :string
    add_column :tweets, :subject, :string
  end
end
