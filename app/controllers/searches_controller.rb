# frozen_string_literal: true

class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:range], params[:word])
    end
  end
end
