class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]
  before_action :check_admin

  def index
    @tag_categories = TagCategory.all
  end

  def new
    @tag = Tag.new
    @tag_categories = TagCategory.all
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "「#{tag_params[:name]}」を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "タグ名を修正しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url, notice: "「#{@tag.name}」を削除しました"
  end


  private
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :tag_category_id)
  end

  def check_admin
    unless current_user.admin?
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
