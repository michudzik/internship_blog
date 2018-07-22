class RemoveAuthors < ActiveRecord::Migration[5.2]
  def change
    drop_table :authors do |t|
      t.string  :name
      t.string  :surname
      t.integer :age

      t.timestamps
    end
  end
end
