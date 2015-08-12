class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question
  before_action :load_vote
  respond_to :json

  def like
    save_vote(1)
  end

  def dislike
    save_vote(-1)
  end

  private

  def save_vote(value)

    return respond_with(@vote, status: 403) if @question.user_id == current_user.id or @vote.persisted?

    @vote.user = current_user
    @vote.save_score(value)

    respond_to do |format|

      if @vote.save
        format.json { render json: @vote }
      else
        format.json { render json: @vote.errors.full_messages, status: :unprocessable_entity }
      end

    end

  end

  def load_question
    @question = Question.find(params[:question])
  end

  def load_vote
    @vote = @question.votes.new unless @vote = @question.votes.find_by(user:current_user.id)
  end

end