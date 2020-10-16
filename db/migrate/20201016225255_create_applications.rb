class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :description
      t.integer :status, default: 0
    end
  end
end
