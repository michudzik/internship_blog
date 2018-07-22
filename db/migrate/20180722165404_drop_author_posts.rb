class DropAuthorPosts < ActiveRecord::Migration[5.2]
  def change
    drop_table :author_posts do |t|
      t.integer   :author_id, index: true
      t.integer   :post_id,   index: true
    end
  end
end
