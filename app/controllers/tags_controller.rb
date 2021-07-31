class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  def index
    @tags = Tag.all
  end

  def show
  end

  def new
    @tag = Tag.new
    @tag_categories = TagCategory.all
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.tag_category_id = tag_params[:tag_category_id][1]

    if @tag.save
      redirect_to @tag, notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url, notice: "Tag was successfully destroyed."
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name, tag_category_id: [])
    end
end
