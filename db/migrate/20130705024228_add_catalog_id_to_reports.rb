class AddCatalogIdToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :catalog_id, :integer
  end

  def self.down
  	remove_column :reports, :catalog_id
  end
end
