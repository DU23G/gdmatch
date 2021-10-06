class Tweet < ApplicationRecord
    default_scope -> { order(updated_at: :desc) }

    is_impressionable

    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :remarks, dependent: :destroy

    has_many :tweet_takers, dependent: :destroy
    has_many :takers, through: :tweet_takers, dependent: :destroy
    # has_many :taked_users, through: :tweet_takers, source: :user

    # validates :hosttime, presence: true
    validates :thema, presence: true
    # validates :number, presence: true
    # validates :level, presence: true
    # validates :meeting, presence: true
    # validates :requiredtime, presence: true
    # validates :limittime, presence: true
    validates :thematype, presence: true
    validates :meeting, length: { maximum: 120 }
    validates :comment, length: { maximum: 120 }
    validates :subject, length: { maximum: 120 }

end
