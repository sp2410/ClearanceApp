class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
	has_many :items, dependent: :destroy
	has_many :clearance_batches, dependent: :destroy

  	enum role: {staff: 0, vendor: 1, admin: 2}
  
 

end
