class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:destroy]
  
  def index
    @post = Post.all
    if user_signed_in?
      @user_mail = current_user.email
    end
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # if params[:genre]
    #   @post.genre = true
    # end
    @post.save
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/posts'
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
    #, profile_id: current_user.profile.id
  end
end
