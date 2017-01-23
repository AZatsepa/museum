class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  def self.search(search)
    where("body LIKE ?", "%#{search}%")
    where("title LIKE ?", "%#{search}%") 
  end
end
