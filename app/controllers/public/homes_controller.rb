class Public::HomesController < ApplicationController
  def top
    @item = Item.all.page(params[:page]).per(4)
  end

  def about
  end

  private

  def item_params
    params.require(:item).permit(:item, :name, :price)
  end
end
