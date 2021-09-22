class TweetTaker < ApplicationRecord    
    belongs_to :taker, class_name: 'User', foreign_key: 'taker_id'
    # has_many :tweets, dependent: :destroys
    belongs_to :tweet
    validates_uniqueness_of :tweet_id, scope: :taker_id
end
