class QuestionsController < ApplicationController
	before_action :load_question, only: [:show, :edit] 

	def index
		@questions = Question.all
	end

	def show
	end

	def new
		@question = Question.new
	end

	def edit
	end

def create
	@question = Question.create(question_params)
	redirect_to @question
end

	private

	def load_question
		@question = Question.find(params[:id])
	end

	def question_params
		params.require(:question).permit(:title, :body)
	end
end
