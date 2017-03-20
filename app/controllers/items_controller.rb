class ItemsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    @items = Item.all    
  end

  # GET /items/1
  def show
    @batch = ClearanceBatch.find(params[:clearance_batch_id])
    @item = @batch.items.find(params[:id])
    @style = Style.find_by_id(@item.style_id)
    
  end

  # GET /items/new
  def new
  	@batch = ClearanceBatch.find(params[:clearance_batch_id])
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @batch = ClearanceBatch.find(params[:clearance_batch_id])
    @item = @batch.items.find(params[:id])
  end

  # POST /items
  def create    
      if current_user.role != "vendor" 

        @batch = ClearanceBatch.find(params[:clearance_batch_id])
        @item = @batch.items.new(item_params)
        @item.user = current_user
        

        if @item.save
          if @item.status.eql? "clearanced"
              @item.clearance!
          end

          if @item.status.eql? "sellable"
                @item.setestimatedprice!
          end

          redirect_to @batch, notice: 'Item was successfully created.'
        else      
          render :new
        end
      else
        redirect_to action: :index
        flash[:alert] = "Sorry, You Are Not Allowed To Create An Item"
      end    
  end

  # PATCH/PUT /items/1
  def update    
      if current_user.role != "vendor" 
        @batch = ClearanceBatch.find(params[:clearance_batch_id])
        @item = @batch.items.find(params[:id])
        @item.user = current_user

        if @item.update_attributes(item_params)
          if @item.status.eql? "clearanced"
            @item.clearance!
          elsif @item.status.eql? "sellable"
            @item.setestimatedprice!
          end

          redirect_to @batch, notice: 'Item was successfully updated.'
          
        else
          render :edit
        end
      else
        redirect_to action: :index
        flash[:alert] = "Sorry, You Are Not Allowed To Update An Item"
      end   
  end

  # DELETE /items/1
  def destroy    
      if current_user.role != "vendor"
        @batch = ClearanceBatch.find(params[:clearance_batch_id])
        @item = @batch.items.find(item_params)

        @item.destroy
        redirect_to @batch, notice: 'Item was successfully destroyed.'
      else
        redirect_to action: :index
        flash[:alert] = "Sorry, You Are Not Allowed To Delete An Item"
      end    
  end

  def search    
    @items = Item.search(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:id, :size, :price_sold, :sold_at, :color, :status, :style_id)
    end

    
end
