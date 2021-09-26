class AddProfilesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sex, :string
    add_column :users, :year, :string
    add_column :users, :job, :string
  end
end
