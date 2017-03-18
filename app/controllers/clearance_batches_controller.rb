class ClearanceBatchesController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create,:buybatch, :destroy ]
  

  def index
    @clearance_batches  = ClearanceBatch.all    
    @clearance_batches = @clearance_batches.search(params[:search]) if params[:search].present?
    
    @itemssearch = Item.search(params[:searchitem]) if params[:searchitem].present?
  end

  def new    
      @clearance = ClearanceBatch.new    
  end

  def create
    if user_signed_in?
      if current_user.role != "vendor" 
        @clearance_batch = ClearanceBatch.new    
        @clearance_batch.save
        redirect_to action: :index
        flash[:alert] = "New Batch Created"
      else      
        redirect_to action: :index
        flash[:alert] = "Sorry, You Are Not Allowed To Create A Batch"
      end          
    else      
      redirect_to action: :index
      flash[:alert] = "Sorry, You Are Not Allowed To Create A Batch"
    end      
  end


  def destroy    
      if current_user.role != "vendor"         
        @clearance_des = ClearanceBatch.find(params[:id])

        if @clearance_des.status == false
          @clearance_des.destroy
          redirect_to action: :index
          flash[:alert] = "Batch Deleted"
        else
          redirect_to action: :index
        end
      else      
        redirect_to action: :index
        flash[:alert] = "Sorry, You Are Not Allowed To Create A Batch"
      end    
  end

  def buybatch    
      if current_user.role == "vendor" 
        @mybatch = ClearanceBatch.find(params[:id])
        @mybatch.user = current_user
        @mybatch.buy!
        @mybatch.save
        
        redirect_to action: :index
        flash[:alert] = "You Bought Batch Number #{params[:id]}"
      else
        redirect_to action: :index
        flash[:alert] = "You Cant buy an item"
      end
  end

  def undobatch
      if current_user.role == "vendor" 
        @mybatch = ClearanceBatch.find(params[:id])
        @mybatch.user = nil
        @mybatch.undo!
        @mybatch.save
        
        redirect_to action: :index
        flash[:alert] = "Okay! We Understand, You dont need Batch #{params[:id]}, We Will Refund the Money Soon"
      else
        redirect_to action: :index
        flash[:alert] = "You Cant buy an item"
      end
  end



  def show
    @clearance_in = ClearanceBatch.find(params[:id])
    @items =  Item.where(clearance_batch_id: params[:id])
    @items = @items.search(params[:search]) if params[:search].present?
    @items =  @items.order(created_at: :desc)    

  end

  def mybatches
    @mybatches = ClearanceBatch.where(user: current_user)        
  end

end
