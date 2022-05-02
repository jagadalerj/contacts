class CreateContactLists < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_lists do |t|
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
