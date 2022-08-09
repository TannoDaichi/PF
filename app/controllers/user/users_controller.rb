class User::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])  
    @posts = @user.posts    
    
  end

  def edit
    @user = User.find(params[:id])
      if @user == current_user
        render "edit"
      else
        @posts = @user.posts
        render 'show'
      end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to action: 'show'  
  end
  
  #いいね一覧表示
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
