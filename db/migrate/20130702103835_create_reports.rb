class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
  def self.down
    drop_table :reports
  end
end
