class DropCommentCommentators < ActiveRecord::Migration[5.2]
  def change
    drop_table :comment_commentators do |t|
      t.integer   :comment_id,        index: true
      t.integer   :commentator_id,    index: true
    end
  end
end
