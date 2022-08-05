class User::PostsController < ApplicationController
    
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params) 
    @post.user_id = current_user.id
    @post.save 
    redirect_to action: 'index' 
  end
    
  def index
    @posts = Post.all
  end
    
  def show
    @posts = Post.all
  end
    
  private
  
  def post_params 
    params.require(:post).permit(:image, :post_text, :shoot_date, :shoot_time, :shoot_address) 
  end
end
