class AddCommentatorIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :commentator_id, :integer, index: true
  end
end
