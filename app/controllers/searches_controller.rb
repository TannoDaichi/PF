class SearchesController < ApplicationController
  #before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:range], params[:word])
    end
  end
  
end
