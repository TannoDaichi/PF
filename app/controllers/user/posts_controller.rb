class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
    
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params) 
    @post.user_id = current_user.id
    if @post.save 
      flash[:notice] = "投稿しました。"
      redirect_to action: 'index' 
    else
      flash[:alret] = "投稿に失敗しました。"
       render :new
    end
  end
    
  def index
    # @user = User.find(params[:id])
    @posts = Post.all
  end
    
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find(params[:id])
      if @post.user == current_user
        render "edit"
      else
        @post = Post.find(params[:id])
        @comment = Comment.new
        render :show
      end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)  
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to action: 'index'
  end
    
  private
  
  def post_params 
    params.require(:post).permit(:image, :post_text, :shoot_date, :shoot_time, :shoot_address) 
  end
end
