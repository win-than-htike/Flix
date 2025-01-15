module FavouritesHelper
  def fave_or_unfave_button(movie, favorite)
    if favorite
      button_to "♡ Unfave", movie_favourite_path(movie, favorite), method: :delete
    else
      button_to "♥️ Fave", movie_favourites_path(movie)
    end
  end
end
