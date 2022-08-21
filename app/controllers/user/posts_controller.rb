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
      flash[:alret] = "投稿に失敗しました。""空白の欄がありますのでご確認ください。"
       render :new
    end
  end
    
  def index
    @posts = Post.published
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
    if @post.update(post_params)
      flash[:notice] = "更新しました。"
      redirect_to action: 'show'
    else
      flash[:alret] = "更新に失敗しました。空白の欄がありますのでご確認ください。"
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to action: 'index'
  end
    
  private
  
  def post_params 
    params.require(:post).permit(:image, :post_text, :shoot_date, :shoot_time, :shoot_address, :is_published_flag) 
  end
end
