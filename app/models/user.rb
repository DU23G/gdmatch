class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :remarks, dependent: :destroy
  
  has_many :tweet_takers, foreign_key: "taker_id", dependent: :destroy

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  validate :tweet_takers_count_must_be_within_limit

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end
  
  # MAX_TWEET_TAKERS_COUNT = 2

  # private
  # def tweet_takers_count_must_be_within_limit
  #   if tweet_taker.tweet_id.count >= MAX_TWEET_TAKERS_COUNT
  #   errors.add("tweet_takers count limit: #{MAX_TWEET_TAKERS_COUNT}")
  #   end
  # end

end
