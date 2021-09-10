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

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

end
