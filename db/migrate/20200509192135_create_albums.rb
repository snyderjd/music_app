class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :is_live, null: false, default: false
      t.integer :band_id, null: false
      t.timestamps

    end
    add_index :albums, :band_id
  end
end

# def change
#   create_table :cat_rental_requests do |t|
#     t.integer :cat_id, null: false
#     t.date :end_date, null: false
#     t.date :start_date, null: false
#     t.string :status, null: false

#     t.timestamps
#   end
#   add_index :cat_rental_requests, :cat_id
# end
