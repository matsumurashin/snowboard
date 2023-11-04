class Admin::GenreController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create

  end

  def edit
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end
