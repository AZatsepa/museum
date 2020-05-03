# frozen_string_literal: true

class PostsChannel < ApplicationCable::Channel
  def follow
    stream_from 'posts'
  end
end
