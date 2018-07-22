class HomeController < ApplicationController
  def welcome
    @posts = Post.all
  end
end
