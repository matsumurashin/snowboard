class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all.page(params[:page]).per(10)
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @items = @@category.products
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :size)
  end
end
