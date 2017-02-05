class CommentsController < ApplicationController
  def index
    @comment = Comment.all  
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def edit
    # render form to browser, who will send to update method 
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.save
      redirect_to @post
    else
      render 'edit'      
    end
  end

  def new
    # render form to browser, who will send to create method 
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      redirect_to @post
    else
      render 'new'      
    end
    
  end


  def update
    
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
