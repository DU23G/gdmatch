class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    validates :name, presence: true, uniqueness: true

    has_many :comments, dependent: :destroy
end