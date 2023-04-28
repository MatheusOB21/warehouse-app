class OrdersController < ApplicationController
  before_action :authenticate_user!, only:[:show, :new] 

  def new
    @warehouse = Warehouse.all
    @supplier = Supplier.all
    
    @order = Order.new
  end

  def create 
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :date_delivery)
    @order = Order.new(order_params)
    @order.user = current_user
   
    if @order.save
      redirect_to @order, notice: "Pedido feito com sucesso"
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end