class AddUserIdToComments < ActiveRecord::Migration[5.2]
  def change
     change_table :comments do |t|
      t.rename :commentator_id, :user_id
    end
  end
end
