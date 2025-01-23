class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie
  def create
    @movie.favourites.create!(user: current_user)
    redirect_to @movie
  end

  def destroy
    favorite = current_user.favourites.find(params[:id])
    favorite.destroy
    redirect_to @movie
  end

private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
