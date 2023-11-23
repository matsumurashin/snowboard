class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_items_nil, only: [:new, :create]

  def new
   @order = Order.new
   @customer = current_customer
   @shipping_address = current_customer.shipping_address
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order.shipping_fee = 800
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = (cart_item.item.price * 1.1 * cart_item.amount).to_i
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
    end
    redirect_to orders_complete_path
  end

  def confirm
     @order = Order.new(order_params)
     @order.shipping_fee = 800
     @cart_items = current_customer.cart_items
     @total = 0
     @cart_items.each do |cart_item|
       @total += cart_item.subtotal
     end
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
       @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
       @order.postal_code = @shipping_address.postal_code
       @order.address = @shipping_address.address
       @order.name = @shipping_address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
      @order_new = Order.new
      render :confirm
  end

  def complete
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(10).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
    @order.shipping_fee = 800
    @total = 0
    @order_detail = OrderDetail.find(current_customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :status, :name, :postal_code, :address, :shipping_fee, :amount_billed)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end

  def cart_items_nil
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end

end
