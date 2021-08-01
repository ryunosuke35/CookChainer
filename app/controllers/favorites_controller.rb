class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorite_posts
  end

  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to post_path(params[:post_id]), notice: "#{favorite.post.user.email}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    post = favorite.post_id
    favorite.destroy
    redirect_to post_path(post), notice: "#{favorite.post.user.email}さんの投稿をお気に入り解除しました"
  end

end
