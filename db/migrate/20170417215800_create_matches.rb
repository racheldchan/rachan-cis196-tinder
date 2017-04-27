class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
