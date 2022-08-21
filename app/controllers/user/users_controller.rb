class User::UsersController < ApplicationController
  before_action :authenticate_user!
  
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
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to action: 'show'
    else
      flash[:alret] = "更新に失敗しました。名前を入力してください"
      render 'edit'
    end
  end
  
  #いいね一覧表示
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  # 退会機能
  def withdrawal
    @user = User.find(params[:user_id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
