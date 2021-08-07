class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:index, :new, :edit, :update, :destroy]
  before_action :set_q, only: [:index2]

  def index
    @posts = Post.where(user_id: current_user.id)
    @next_level = LevelSetting.find_by(level: current_user.level + 1)
    @now_level = LevelSetting.find_by(level: current_user.level)
  end

  def index2
    if params[:q].present?
      @posts = @q.result
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts
    else
      @posts = Post.all
    end
    @posts = @posts.page(params[:page]).per(30)
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


      user = current_user
      user.update(exp_point: user.exp_point + 5)

      levelSetting = LevelSetting.find_by(level: user.level + 1)
      if levelSetting.thresold <= user.exp_point
        user.update(level: user.level + 1)
      end
      redirect_to action: :index


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
