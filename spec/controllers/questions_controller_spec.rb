require 'rails_helper'

	describe QuestionsController do
	  let(:user) { create(:user) }
      let(:questions) { create_list(:question, 2, user: user) }
      let(:question) { create(:question, user: user) }

	  describe "GET #index" do
	   	    
	    before { get :index } 
	
	    it "populates an array of all questions" do       
	      expect(assigns(:questions)).to match_array(questions)
	    end
	    it "render index view" do
	      expect(response).to render_template :index
	    end
	  end

	  describe 'GET #show' do    
	    before { get :show, id: question }

	    it 'assigns the requested question to question' do
	      expect(assigns(:question)).to eq question
	    end
	    it 'renders show view' do
	      expect(response).to render_template :show
	    end
	  end
  
	  describe 'GET #new' do
        sign_in_user

		before { get :new }

		it 'get a new question object' do
		  expect(assigns(:question)).to be_a_new(Question)
		end

		it { should render_template :new }
	  end

	  describe 'GET #edit' do 	
        sign_in_user

	  	before { get :edit, id: question }

	  	it 'assings the requested question to @question'do
	  	  expect(assigns(:question)).to eq question
	    end
	    it 'renders edit view' do
	      expect(response).to render_template :edit
	    end
	  end

	  describe 'POST #create' do
        sign_in_user

	  	context 'with valid attributes' do
	  		it 'saves new question to database'do
	  			expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
	  		end
	  		it 'redirects to show view'do
	  			post :create, question: attributes_for(:question)
	  			expect(response).to redirect_to question_path(assigns(:question))
	  	    end
	  	end

	  	context 'with invalid attributes' do
	  		it 'does not save the question'do
	  			expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
	  		end	
	  		it 're-renders new view' do
		        post :create, question: attributes_for(:invalid_question)
		        expect(response).to render_template :new
            end
	  	end

	  end

	end
  