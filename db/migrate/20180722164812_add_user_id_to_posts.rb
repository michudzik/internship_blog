class AddUserIdToPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.rename :author_id, :user_id
    end
  end
end