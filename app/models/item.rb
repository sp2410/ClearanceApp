class Item < ActiveRecord::Base
  

  include PublicActivity::Model
  tracked owner: ->(controller, model){controller && controller.current_user}

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :style
  belongs_to :user
  belongs_to :clearance_batch
  validates :id, :uniqueness => true



  


  scope :sellable, -> { where(status: 'sellable') }

  def clearance!
    update_attributes!(status: 'clearanced', 
                       price_sold: style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE)
  end

  def setestimatedprice!
  	update_attributes!(status: 'sellable', price_sold: style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE)
  end
  
  def self.search(params)
    if params 
      self.where("id like ?", "%#{params}%")
    else
      self.all
    end
  end


end
