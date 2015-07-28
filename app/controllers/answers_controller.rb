class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:best, :update, :destroy]

  def best
    @question = Question.where(params[:question_id]).first
    @ex_best = @question.answer_best
    @answer.mark_as_best if @answer.user_id == current_user.id
    @ex_best.reload if @ex_best
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    flash[:notice] = "Answer successfully added!"  if @answer.save
  end

  def update
    flash[:notice] = "Answer successfully updated!" if @answer.user_id == current_user.id && @answer.update(answer_params)  
  end

  def destroy
    flash[:notice] = "Answer successfully destroyed!" if @answer.user_id == current_user.id && @answer.destroy
  end

  private

  def load_question
     @question = Question.find(params[:question_id])
   end
 
   def load_answer
     @answer = Answer.find(params[:id])
   end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes:[:file])
  end

end
