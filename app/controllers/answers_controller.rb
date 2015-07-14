class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy]

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
    params.require(:answer).permit(:body)
  end

end
