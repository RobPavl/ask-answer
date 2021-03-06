class QuestionsController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
	before_action :load_question, only: [:show, :update, :destroy]
	before_action :save_current_user, only: [:show, :index]

	def index
		@questions = Question.all
	end

	def show
		@answers = @question.answers
	end

	def new
		@question = Question.new
	end

	def update
		flash[:notice] = "Question successfully updated!" if @question.user_id == current_user.id && @question.update(question_params)
	end

	def create
		@question = Question.create(question_params)
		@question.user = current_user
		  if @question.save
		  	PrivatePub.publish_to '/questions/index', question: @question.to_json
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

    def save_current_user
	    if user_signed_in?
	      gon.current_user = current_user.id if user_signed_in?
	      gon.question_author = @question.user_id if @question
	    end
    end

end
