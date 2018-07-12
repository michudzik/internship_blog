require 'rails_helper'

RSpec.describe Post, type: :model do
  
  it 'should have proper attributes' do
    expect(subject.attributes).to include('title', 'content', 'author_id')
  end

  it 'should require title, content and proper author_id' do
    author = Author.create(name: 'name', surname: 'surname')
    expect(Post.new).not_to be_valid
    expect(Post.new(title: 'title')).not_to be_valid
    expect(Post.new(title: 'title', content: 'longcontent')).not_to be_valid
    expect(Post.new(title: 'title', content: 'longcontent', author_id: author.id)).to be_valid
  end

  it 'should require titles to be unique' do
    author = Author.create(name: 'name', surname: 'surname')
    post = Post.create(title: 'title', content: 'longcontent', author_id: author.id)
    expect(post).to be_valid
    expect(Post.new(title: 'title', content: 'newtestcontent', author_id: author.id)).not_to be_valid
  end

  it 'should require title to be shorter than 80 characters' do
    author = Author.create(name: 'name', surname: 'surname')
    expect(Post.new(title: 'title', content: 'testcontent', author_id: author.id)).to be_valid
    expect(Post.new(title: 't' * 81, content: 'testcontent', author_id: author.id)).not_to be_valid
  end

  it 'should require content to be longer than 10 characters and longer than 500 characters' do
    author = Author.create(name: 'name', surname: 'surname')
    expect(Post.new(title: 'title', content: 'a' * 9, author_id: author.id)).not_to be_valid
    expect(Post.new(title: 'title', content: 'a' * 501, author_id: author.id)).not_to be_valid
    expect(Post.new(title: 'title', content: 'a' * 500, author_id: author.id)).to be_valid
  end

  it 'should have old scope' do
    author = Author.create(name: 'name', surname: 'surname')
    early_post = Post.create(title: 'title', content: 'testcontent', author_id: author.id)
    old_post = Post.create(title: 'title1', content: 'testcontent', author_id: author.id)
    old_post.update(created_at: 41.minutes.ago)

    expect(Post.old).not_to include(early_post)
    expect(Post.old).to include(old_post)
  end

  it 'should belong to an author' do
    t = Post.reflect_on_association(:author)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should have many comments' do
    t = Post.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

end