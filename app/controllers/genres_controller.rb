class GenresController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: "Genre successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(movie_params)
      redirect_to genres_path, notice: "Genre successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to movies_path, status: :see_other,
      danger: "Genre successfully delete!"
  end

private

  def genre_params
    params.require(:genre).
      permit(:name)
  end
end
