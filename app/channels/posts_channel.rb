class PostsChannel < ApplicationCable::Channel
  def follow
    stream_from 'posts'
  end
end
