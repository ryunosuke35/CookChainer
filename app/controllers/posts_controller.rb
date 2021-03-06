class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_q, only: [:index]
  before_action :check_user, only: [:edit]
  skip_before_action :authenticate_user!, only: [:top, :index, :show]

  def index
    if params[:q].present?
      @posts = @q.result
    elsif params[:category_id].present?
      @posts = Category.find(params[:category_id]).posts
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts
    else
      @posts = Post.all
    end
    @posts = @posts.order(created_at: "DESC").page(params[:page]).per(30)
    @categories = Category.all
    @tag_categories = TagCategory.all
  end

  def show
  end

  def new
    @post = Post.new
    @tag_categories = TagCategory.all
    @categories = Category.all
  end

  def edit
    @tag_categories = TagCategory.all
    @categories = Category.all
  end

  def create
    if post_params[:tag_ids].reject(&:blank?).count < 5
      @post = current_user.posts.build(post_params)

      if @post.save
        user = current_user
        user.update(exp_point: user.exp_point + 5)
        levelSetting = LevelSetting.find_by(level: user.level + 1)
        if levelSetting.thresold <= user.exp_point
          user.update(level: user.level + 1)
        end
        redirect_to user_path(current_user), notice: "投稿しました!"
      else
        redirect_to new_post_path, notice: "料理名を入力してください"
      end
    else
      redirect_to new_post_path, notice: "食材は4つまで選択可能です"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to user_path(current_user), notice: "投稿内容を編集しました!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user), notice: "「#{@post.name}」を削除しました"
  end


  private
  def set_q
    @q = Post.ransack(params[:q])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :url, :memo, :image, :image_cache, :search, :category_ids, tag_ids: [] )
  end

  def check_user
    unless current_user == @post.user
      redirect_to user_path(current_user)
    end
  end

end
