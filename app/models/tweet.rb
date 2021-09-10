class Tweet < ApplicationRecord
    default_scope -> { order(created_at: :desc) }

    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :remarks, dependent: :destroy

    has_many :tweet_takers, dependent: :destroy
    has_many :takers, through: :tweet_takers, dependent: :destroy

    validate :tweet_takers_count_must_be_within_limit

#   MAX_TWEET_TAKERS_COUNT = 2

#   private
#   def tweet_takers_count_must_be_within_limit
#     if tweets.tweet_id.count >= MAX_TWEET_TAKERS_COUNT
#     errors.add("tweet_takers count limit: #{MAX_TWEET_TAKERS_COUNT}")
#     end
#   end
end
