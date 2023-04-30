class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

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
    else
      @warehouse = Warehouse.all
      @supplier = Supplier.all
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: "Você não tem acesso a esse pedido"
    end
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")

  end
  
end