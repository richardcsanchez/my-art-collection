class CreateMediums < ActiveRecord::Migration
  def change
    create_table :mediums do |t|
      t.string :type
    end
  end
end
