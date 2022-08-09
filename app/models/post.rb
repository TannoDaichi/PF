class Post < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
    
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images4/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    # if type == "shoot_date"
      if search == "perfect_match"
        @post = Post.where("shoot_date LIKE?","#{word}")
      elsif search == "forward_match"
        @post = Post.where("shoot_date LIKE?","#{word}%")
      elsif search == "backward_match"
        @post = Post.where("shoot_date LIKE?","%#{word}")
      elsif search == "partial_match"
        @post = Post.where("shoot_date LIKE?","%#{word}%")
      else
        @post = Post.all
      end
    # elsif type == "shoot_time"
    #   if search == "perfect_match"
    #     @post = Post.where("shoot_time LIKE?","#{word}")
    #   elsif search == "forward_match"
    #     @post = Post.where("shoot_time LIKE?","#{word}%")
    #   elsif search == "backward_match"
    #     @post = Post.where("shoot_time LIKE?","%#{word}")
    #   elsif search == "partial_match"
    #     @post = Post.where("shoot_time LIKE?","%#{word}%")
    #   else
    #     @post = Post.all
    #   end
    # end
  end
    
end
