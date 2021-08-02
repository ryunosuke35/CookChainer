class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorite_posts
  end

  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to index2_posts_path, notice: "#{favorite.post.user.email}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = Favorite.find_by(id: params[:id]).destroy
    redirect_to index2_posts_path, notice: "#{favorite.post.user.email}さんの投稿をお気に入り解除しました"
  end
end
