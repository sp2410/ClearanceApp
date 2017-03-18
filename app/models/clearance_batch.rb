class ClearanceBatch < ActiveRecord::Base

	include PublicActivity::Model
	tracked owner: ->(controller, model){controller && controller.current_user}
	
	has_many :items, dependent: :destroy
	belongs_to :user



  def buy!
    update_attributes!(status: true)

  end

  def undo!
  	update_attributes!(status: false)
  end

  def self.search(params)
    if params 
      self.where("id like ?", "%#{params}%")
    else
      self.all
    end
  end
 

end
