class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable
  respond_to :json

  def create

    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      PrivatePub.publish_to "/question/#{question_id}/comments", comment: @comment.to_json
      respond_with(@comment.to_json, location: question_path(@commentable))
    else
      render nothing: true
    end

  end

  private

  def question_id
    @commentable.has_attribute?(:question_id) ? @commentable.question_id : @commentable.id
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def commentable
    params[:commentable]
  end

  def load_commentable
    @commentable = commentable.classify.constantize.find(params["#{commentable}_id"])
  end
end
