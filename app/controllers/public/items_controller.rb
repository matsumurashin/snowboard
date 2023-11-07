class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all.page(params[:page]).per(10)
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @items.where(genre_id: params[:genre_id])
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :size, :genre_id)
  end
end
