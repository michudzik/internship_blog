class CommentCommentator < ActiveRecord::Base
  belongs_to :comment
  belongs_to :commentator
end