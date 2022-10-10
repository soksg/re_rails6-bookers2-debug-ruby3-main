class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence:true
  validates :body, length:{maximum:200}


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def self.looks(search, word)
    if search == "perfect_match"
      @book=Book.where("title LIKE?", "#{word}")
    elsif search == "foward_match"
      @book=Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book=Book.where("title LIKE?", "%#{word}")
    elsif search == "pertial_match"
      @book=Book.where("title LIKE?", "%#{word}%")
    else
      @book=Book.all
    end
  end

end
