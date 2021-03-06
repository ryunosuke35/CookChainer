class TagCategoriesController < ApplicationController
  before_action :set_tag_category, only: %i[ show edit update destroy ]
  before_action :check_admin

  def index
    @tag_categories = TagCategory.all
  end

  def new
    @tag_category = TagCategory.new
  end

  def edit
  end

  def create
    @tag_category = TagCategory.new(tag_category_params)
    if @tag_category.save
      redirect_to tag_categories_path, notice: "「#{tag_category_params[:name]}」を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag_category.update(tag_category_params)
      redirect_to tag_categories_path, notice: "タグカテゴリー名を修正しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag_category.destroy
    redirect_to tag_categories_url, notice: "「#{@tag_category.name}」を削除しました"
  end

  private
  def set_tag_category
    @tag_category = TagCategory.find(params[:id])
  end

  def tag_category_params
    params.require(:tag_category).permit(:name)
  end

  def check_admin
    unless current_user.admin?
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
