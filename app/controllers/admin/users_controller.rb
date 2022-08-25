class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, only: [:withdrawal]
  
  def show
    @user = User.find(params[:id])  
    @posts = @user.posts    
  end
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
    # ゲストユーザの制限
    if @user.name == "guestuser"
      redirect_to admin_user_path, notice: 'ゲストユーザーにこの動作はできません。'
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
  
  # 退会機能
  def withdrawal
    @user = User.find(params[:user_id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_user_path
  end
  
  private
  
  # ゲストユーザの制限
  def ensure_guest_user
    @user = User.find(params[:user_id])
    if @user.name == "guestuser"
      redirect_to admin_users_path, notice: 'ゲストユーザーにこの動作はできません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
