class AddUserIndexToBatch < ActiveRecord::Migration
  def change
  	add_reference :clearance_batches, :user, index: true
  end
end
