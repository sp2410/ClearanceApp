class AddStatusandBoughByToClearanceBatch < ActiveRecord::Migration
  def change
  	add_column :clearance_batches, :status, :boolean, :default => false
  	add_column :clearance_batches, :boughtby, :string, :default => ""
  end
end
