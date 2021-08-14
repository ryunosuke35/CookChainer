class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      binding.pry
      redirect_to categories_path, notice: "「#{category_params[:name]}」を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "カテゴリー名を修正しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: "「#{@category.name}」を削除しました"
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
