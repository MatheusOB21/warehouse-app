class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order_id_and_check_user, only: [:show, :edit,:update, :delivered, :canceled]

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

  def edit
    @warehouse = Warehouse.all
    @supplier = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :date_delivery)
    if @order.update(order_params) 
      redirect_to @order
    end
  end

  def show

  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
    if @orders.length == 1
      redirect_to @orders[0]
    end
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end
  
  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def find_order_id_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: "Você não tem acesso a esse pedido"
    end
  end
  
end