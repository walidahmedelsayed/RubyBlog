class CommentsController < ApplicationController
  def show

  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to  post_path(@comment.post_id)
    else
      render 'edit'
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
