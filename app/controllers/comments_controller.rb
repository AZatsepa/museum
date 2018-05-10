class CommentsController < ApplicationController
  load_and_authorize_resource class: 'Comment'
  before_action :find_post, only: %i[edit new create update destroy]
  # load_resource class: 'Post', id_param: :post_id, only: %i[create]
  # load_and_authorize_resource class: 'Post', id_param: :post_id

  def show; end

  def edit
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    raise CanCan::AccessDenied unless can? :create, @comment
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def update
    return redirect_to post_path(@post) if @comment.update(comment_params)
    render 'edit'
  end

  def destroy
    @comment.destroy

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
    authorize! :read, @post
  end
end
