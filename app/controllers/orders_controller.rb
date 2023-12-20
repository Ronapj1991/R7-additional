class OrdersController < ApplicationController
    skip_before_action :verify_authenticity_token
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_order, only: %i[ show edit update destroy ]
    
    def index
        @orders = Order.all
    end
    
    def show
    end
    
    def new
        @order = Order.new
    end
    
    def edit
    end
    
    
    def create
        @order = Order.new(order_params)
        if @order.save
            flash.notice = "The order was created successfully"
            redirect_to @order
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def update
        @order.update(order_params)
        if @order.save
            flash.notice = "the order was updated successfully"
            redirect_to @order
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @order.destroy
        
        respond_to do |format|
          format.html { redirect_to orders_url }
          format.json { head :no_content }
        end
    end
    
    private
    
    def set_order
        @order = Order.find(params[:id])
    end
    
    def order_params
        params.require(:order).permit(:product_name, :product_count, :customer_id)
    end
end
