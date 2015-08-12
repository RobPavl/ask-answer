class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :load_votable, only: [:like,:dislike]
  before_action :assign_vote, only: [:like,:dislike]
  respond_to :json

  def like
    save_vote(1)
  end

  def dislike
    save_vote(-1)
  end

  def cancel
    @vote = Vote.find(params[:id])

    return respond_with(@vote, status: 403) if  @vote.user_id != current_user.id

    @votable = @vote.votable

    respond_to do |format|

      if @vote.destroy
       format.json { render json: @votable, status: 200 }
      else
       format.json { render json: @votable, status: :unprocessable_entity }
      end

    end
  end

  private

  def save_vote(value)

    return respond_with(@vote, status: 403) if @vote.persisted?

    @vote.save_score(value)

    respond_to do |format|

      if @vote.save
        format.json { render json: @vote, status: 200  }
      else
        format.json { render json: @vote, status: :unprocessable_entity }
      end

    end

  end

  def load_votable
    @question = Question.find(params[:question])
    respond_with(Vote.new, status: 403) if @question.user_id == current_user.id
  end

  def assign_vote
    @vote = Vote.find_or_initialize_by(votable:@question, user: current_user)
  end

end