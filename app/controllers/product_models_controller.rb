class ProductModelsController < ApplicationController
    before_action :product_model_set_id, only: [:show]
    
    before_action :authenticate_user!, only:[:index, :show, :new] 

    def index
        @product_models = ProductModel.all
    end

    def show

    end

    def new
        supplier_all
        @product_model = ProductModel.new    
    end

    def create
        product_model_params = params.require(:product_model).permit(:name, :weight, :height, :depth, :width, :sku, :supplier_id)
        @product_model = ProductModel.new(product_model_params)
        
        if @product_model.save
          redirect_to @product_model, notice: "Modelo de produto cadastrado com sucesso."
        else
          supplier_all
          flash.now[:notice] = "Modelo de produto não cadastrado."
          render 'new'
        end
    end

    private

    def product_model_set_id
        @product_model = ProductModel.find(params[:id])
    end

    def supplier_all
        @suppliers = Supplier.all
    end
end