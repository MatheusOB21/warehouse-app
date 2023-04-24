class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show]
    
    def index
        @supplier = Supplier.all
    end

    def show
        
    end

    private

    def set_supplier
        @supplier = Supplier.find(params[:id])
    end

end