class CommentsController < ApplicationController
  def index
    @comment = Comment.all  
  end

  def show
    
  end

  def edit
    # render form to browser, who will send to update method 
  end

  def new
    # render form to browser, who will send to create method 
    
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def comment_params
    params.permit(:text)
  end
end
