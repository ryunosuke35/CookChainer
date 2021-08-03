class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:index, :new, :edit, :update, :destroy]
  before_action :set_q, only: [:index2]

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def index2
    if params[:q].present?
      @posts = @q.result
    elsif params[:id].present?
      @posts = Category.find(params[:id]).posts
    else
      @posts = Post.all
    end
    @posts = @posts.page(params[:page]).per(10)
    @categories = Category.all
    @tag_categories = TagCategory.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end


  private

  def set_q
    @q = Post.ransack(params[:q])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :url, :memo, :image, :image_cache, :search, tag_ids: [], category_ids: [])
  end
end
