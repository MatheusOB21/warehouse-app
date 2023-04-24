class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show]
    
    def index
        @supplier = Supplier.all
    end

    def show
        
    end

    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new(supplier_params)
        if @supplier.save 
          redirect_to suppliers_path, notice: "Fornecedor registado com sucesso!"
        else
          flash[:notice] = "Fornecedor não cadastrado!"
          render 'new'
        end
    end

    private

    def set_supplier
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params 
      params.require(:supplier).permit(:brand_name, :corporate_name, :registration_number, :full_address, :city, :state, :email)
   end 

end