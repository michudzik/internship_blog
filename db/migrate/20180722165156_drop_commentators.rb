class DropCommentators < ActiveRecord::Migration[5.2]
  def change
    drop_table :commentators do |t|
      t.string :name

      t.timestamp
    end
  end
end
