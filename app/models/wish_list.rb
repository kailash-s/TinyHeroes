class WishList < ApplicationRecord
  belongs_to :user
  scope :starts_with, ->(name) { where("name like ?", "#{name}%") }
  has_one_attached :photo
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  def children_who_liked(current_user)
    list = likes.select {|like| like.user.parent == current_user}.map do |like|
      like.user.first_name.capitalize
    end
    if list.empty?
      return "😢"
    else
      return "Claimed by #{list.uniq.to_sentence}"
    end
  end
end
