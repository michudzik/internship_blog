require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it 'should have proper attributes' do
    expect(subject.attributes).to include('post_id', 'content', 'commentator_id')
  end

  it 'should belong to a commentator' do
    t = Comment.reflect_on_association(:commentator)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    t = Comment.reflect_on_association(:post)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should require content, post_id and commentator_id to be present' do
    author = Author.create(name: 'name', surname: 'surname')
    post = Post.create(title: 'title', content: 'longcontent', author_id: author.id)
    commentator = Commentator.create(name: 'test')

    expect(Comment.new).not_to be_valid
    expect(Comment.new(post_id: post.id)).not_to be_valid
    expect(Comment.new(post_id: post.id, commentator_id: commentator.id)).not_to be_valid
    expect(Comment.new(post_id: post.id, content: 'testcontent', commentator_id: commentator.id)).to be_valid
  end

  it 'should requre content to be shorter than 160 characters and longer than 8 characters' do
    author = Author.create(name: 'name', surname: 'surname')
    post = Post.create(title: 'title', content: 'longcontent', author_id: author.id)
    commentator = Commentator.create(name: 'test')

    expect(Comment.new(post_id: post.id, content: 't' * 160, commentator_id: commentator.id)).to be_valid
    expect(Comment.new(post_id: post.id, content: 't' * 161, commentator_id: commentator.id)).not_to be_valid
    expect(Comment.new(post_id: post.id, content: 't' * 7, commentator_id: commentator.id)).not_to be_valid
  end

end
  