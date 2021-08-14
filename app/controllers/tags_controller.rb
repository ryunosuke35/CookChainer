class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

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
    if tag_params[:tag_category_id].reject(&:blank?).count < 2
      @tag = Tag.new(tag_params)
      @tag.tag_category_id = tag_params[:tag_category_id][1]

      if @tag.save
        redirect_to tags_path, notice: "「#{tag_params[:name]}」を作成しました"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_tag_path, notice: "カテゴリーを1つ選択してください"
    end

  end

  def update
    if tag_params[:tag_category_id].reject(&:blank?).count < 2
  
      if @tag.update(tag_params)
        bindging.pry
        redirect_to @tag, notice: "タグ名を修正しました"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to edit_tag_path(@tag), notice: "カテゴリーを1つ選択してください"
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
      params.require(:tag).permit(:name, tag_category_id: [])
    end
end
