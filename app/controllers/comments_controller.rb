class CommentsController < ApplicationController
  # before_action :authenticate_user!

  def create
    @anon = Anon.find(params[:anon_id])
    @comment = @anon.comments.build(comment_params)
    @comment.user = current_user
  
    if @comment.save
      respond_to do |format|
        format.html { redirect_to anon_path(@anon), notice: 'Comment added successfully.' }
        format.js   # This triggers the create.js.erb response
      end
    else
      respond_to do |format|
        format.html { redirect_to anon_path(@anon), alert: 'Failed to add comment.' }
        format.js   # Handle failed submission
      end
    end
  end  

  def destroy
    @anon = Anon.find(params[:anon_id])
    @comment = @anon.comments.find(params[:id])

    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      head :no_content
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
