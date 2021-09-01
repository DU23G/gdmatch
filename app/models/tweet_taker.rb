class TweetTaker < ApplicationRecord
    belongs_to :taker, class_name: 'User', foreign_key: 'taker_id'
    validates_uniqueness_of :tweet_id, scope: :taker_id
end
