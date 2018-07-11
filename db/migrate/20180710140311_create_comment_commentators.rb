class CreateCommentCommentators < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_commentators do |t|
      t.integer   :comment_id,        index: true
      t.integer   :commentator_id,    index: true
    end
  end
end
