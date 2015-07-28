class QuestionsController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
	before_action :load_question, only: [:show, :update, :destroy]

	def index
		@questions = Question.all
	end

	def show
		@answers = @question.answers.to_ary
	    @answer = @question.answers.build
	    @answer.attachments.build
	end

	def new
		@question = Question.new
		@question.attachments.build
	end

	def update
		flash[:notice] = "Question successfully updated!" if @question.user_id == current_user.id && @question.update(question_params)
	end

	def create
		@question = Question.create(question_params)
		@question.user = current_user
		  if @question.save
	        redirect_to question_path(@question), flash: { notice: "Question successfully created!"}
	      else
		    render :new
	      end
	end

	def destroy
		@question.destroy if @question.user_id == current_user.id
		redirect_to questions_path
	end

	private

	def load_question
		@question = Question.find(params[:id])
	end

	def question_params
		params.require(:question).permit(:title, :body, attachments_attributes:[:file])
	end
end
