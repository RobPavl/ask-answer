class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Answer successfully added!"
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy if @answer.user_id == current_user.id
    redirect_to @answer.question
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
