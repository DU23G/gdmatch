class Tweet < ApplicationRecord
    default_scope -> { order(created_at: :desc) }

    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :remarks, dependent: :destroy

    has_many :tweet_takers, dependent: :destroy
    has_many :takers, through: :tweet_takers, dependent: :destroy

end
