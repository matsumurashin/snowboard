class Public::HomesController < ApplicationController
  def top
    @items = Item.all.page(params[:page]).per(4)
    @genres = Genre.all
  end

  def about
  end

  private

  def item_params
    params.require(:item).permit(:item, :name, :price)
  end
end
