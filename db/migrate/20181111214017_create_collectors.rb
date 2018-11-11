class CreateCollectors < ActiveRecord::Migration
  def change
    create_table :collectors do |t|
      t.string :email
      t.string :username
      t.string :password_digest
    end
  end
end
