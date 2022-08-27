# frozen_string_literal: true

class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :post_text, presence: true
  validates :shoot_date, presence: true
  validates :shoot_time, presence: true
  validates :shoot_address, presence: true

  # 公開・非公開機能
  scope :published, -> { where(is_published_flag: true) }
  scope :unpublished, -> { where(is_published_flag: false) }

  # いいね機能
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join("app/assets/images4/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image
  end

  # 検索方法分岐
  def self.looks(search, shoot_type, word)
    # 完全一致
    if search == "perfect_match"
      if shoot_type == "投稿（撮影場所）"
        @post = Post.where("shoot_address LIKE?", "#{word}")
      elsif shoot_type == "投稿（撮影時間）"
        @post = Post.where("shoot_time LIKE?", "#{word}")
      elsif shoot_type == "投稿（撮影日時）"
        @post = Post.where("shoot_date LIKE?", "#{word}")
      else
        @post = Post.all
      end
    # 前方一致
    elsif search == "forward_match"
      if shoot_type == "投稿（撮影場所）"
        @post = Post.where("shoot_address LIKE?", "#{word}%")
      elsif shoot_type == "投稿（撮影時間）"
        @post = Post.where("shoot_time LIKE?", "#{word}%")
      elsif shoot_type == "投稿（撮影日時）"
        @post = Post.where("shoot_date LIKE?", "#{word}%")
      else
        @post = Post.all
      end
    # 後方一致
    elsif search == "backward_match"
      if shoot_type == "投稿（撮影場所）"
        @post = Post.where("shoot_address LIKE?", "%#{word}")
      elsif shoot_type == "投稿（撮影時間）"
        @post = Post.where("shoot_time LIKE?", "%#{word}")
      elsif shoot_type == "投稿（撮影日時）"
        @post = Post.where("shoot_date LIKE?", "%#{word}")
      else
        @post = Post.all
      end
    # あいまい一致（検索したワードがどこかしらに入っている場合）
    elsif search == "partial_match"
      if shoot_type == "投稿（撮影場所）"
        @post = Post.where("shoot_address LIKE?", "%#{word}%")
      elsif shoot_type == "投稿（撮影時間）"
        @post = Post.where("shoot_time LIKE?", "%#{word}%")
      elsif shoot_type == "投稿（撮影日時）"
        @post = Post.where("shoot_date LIKE?", "%#{word}%")
      else
        @post = Post.all
      end
    else
      @post = Post.all
    end
  end
end
