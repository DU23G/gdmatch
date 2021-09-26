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
  has_many :taked_tweets, through: :tweet_takers, source: :tweet

  validates :name, presence: true
  validates :sex, presence: true
  validates :year, presence: true
  validates :profile, length: { maximum: 200 }

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  
end
